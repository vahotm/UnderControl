//
//  AuthManager.h
//  Nest
//
//  Created by ivanSamalazau on 14.1.16.
//

#import <Foundation/Foundation.h>

@class AccessToken;
@interface AuthManager : NSObject

+ (NSString *)clientId;

+ (NSString *)authorizationURL;
+ (NSString *)accessTokenURLWithAuthCode:(NSString *)code;
+ (NSString *)redirectURL;
+ (NSString *)state;

+ (instancetype)sharedManager;

@property (nonatomic, strong) NSString *authCode;
@property (nonatomic, strong) AccessToken *accessToken;

#pragma mark - Request
- (void)requestAuthTokenWithSuccess:(void (^)(NSString *authToken))success failure:(void (^)(NSError *error))failure;

#pragma mark - Session
- (BOOL)isValidSession;
- (void)logout;


@end
