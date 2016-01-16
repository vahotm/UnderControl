//
//  FirebaseManager.h
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Foundation/Foundation.h>


FOUNDATION_EXPORT NSString *const kFirebaseDidUpdateStateNotification;
FOUNDATION_EXPORT NSString *const kFirebaseNotificationStateKey;
FOUNDATION_EXPORT NSString *const kFirebaseThermostatsPath;


@class State;
@class FDataSnapshot;
@interface FirebaseManager : NSObject

+ (instancetype)sharedManager;

- (void)addSubscriptionToURL:(NSString *)URL withBlock:(void (^)(id data))block;
- (void)removeSubscriptionToURL:(NSString *)URL;
- (void)setValues:(NSDictionary *)values forURL:(NSString *)URL;

@property (nonatomic, strong) State *state;


@end
