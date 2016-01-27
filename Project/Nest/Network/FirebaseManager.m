//
//  FirebaseManager.m
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//

#import "FirebaseManager.h"
#import "AuthManager.h"
#import "AccessToken.h"
#import "State.h"

#import <Firebase/Firebase.h>


NSString *const kFirebaseDidUpdateStateNotification = @"FirebaseDidUpdateStateNotification";
NSString *const kFirebaseNotificationStateKey = @"state";

NSString *const kFirebaseUrl = @"https://developer-api.nest.com/";

NSString *const kFirebaseThermostatsPath = @"devices/thermostats";


@interface FirebaseManager ()
@property (nonatomic, strong) Firebase *database;
@property (nonatomic, strong) NSMutableDictionary *subscribedURLs;
@property (nonatomic, strong) NSMutableDictionary *childDatabases;
@property (nonatomic, strong) NSMutableDictionary *firebaseHandlers;
@end


@implementation FirebaseManager


static FirebaseManager *sharedInstance;

+ (instancetype)sharedManager
{
    static dispatch_once_t singletoneOnce;
    dispatch_once(&singletoneOnce, ^
                  {
                      if (sharedInstance == nil)
                      {
                          sharedInstance = [[self alloc] init];
                      }
                  });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.subscribedURLs = [[NSMutableDictionary alloc] init];
        self.childDatabases = [[NSMutableDictionary alloc] init];
        self.firebaseHandlers = [[NSMutableDictionary alloc] init];
        self.database = [[Firebase alloc] initWithUrl:kFirebaseUrl];
        
        WEAKIFY_SELF
        [SVProgressHUD showWithStatus:@"Connecting"];
        [self.database authWithCredential:[AuthManager sharedManager].accessToken.token
                      withCompletionBlock:^(NSError *error, id data) {
                          STRONGIFY_SELF
                          [SVProgressHUD dismiss];
                          if (error != nil) {
                              [SVProgressHUD showErrorWithStatus:@"Failed to connect to Firebase"];
                          }
                          else {
                              [self.database observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
                                  NSError *error = nil;
                                  State *state = [MTLJSONAdapter modelOfClass:[State class]
                                                           fromJSONDictionary:snapshot.value
                                                                        error:&error];
                                  NSAssert(state != nil, @"%@", error.localizedDescription);
                                  
                                  self.state = state;
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      [[NSNotificationCenter defaultCenter] postNotificationName:kFirebaseDidUpdateStateNotification
                                                                                          object:nil
                                                                                        userInfo:@{kFirebaseNotificationStateKey : self.state}];
                                  });
                              }];
                          }

                      } withCancelBlock:^(NSError *error) {
                          
                          [SVProgressHUD dismiss];
                          [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                      }];
    }
    return self;
}

- (void)addSubscriptionToURL:(NSString *)URL withBlock:(void (^)(id data))block
{
    if ([self.subscribedURLs objectForKey:URL]) {
        
        // Don't add another subscription
        block([self.subscribedURLs objectForKey:URL]);
        
    } else {
        Firebase *newFirebase = [self.database childByAppendingPath:URL];
        
        FirebaseHandle handle = [newFirebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            [self.subscribedURLs setObject:snapshot forKey:URL];
            block(snapshot.value);
        }];
        
        [self.childDatabases setObject:newFirebase forKey:URL];
        [self.firebaseHandlers setObject:@(handle) forKey:URL];
    }
}

- (void)removeSubscriptionToURL:(NSString *)URL
{
    [self.subscribedURLs removeObjectForKey:URL];
    FirebaseHandle handle = [self.firebaseHandlers[URL] integerValue];
    Firebase *firebase = self.childDatabases[URL];
    [firebase removeObserverWithHandle:handle];
}

- (void)setValues:(NSDictionary *)values forURL:(NSString *)URL
{
    if ([self.subscribedURLs objectForKey:URL]) {
        [[self.childDatabases objectForKey:URL]  runTransactionBlock:^FTransactionResult *(FMutableData *currentData) {
            [currentData setValue:values];
            return [FTransactionResult successWithValue:currentData];
        } andCompletionBlock:^(NSError *error, BOOL committed, FDataSnapshot *snapshot) {
            if (error) {
                NSLog(@"Error: %@", error);
            }
        } withLocalEvents:NO];
    }
}



@end
