//
//  AuthManager.h
//  Nest
//
//  Created by ivanSamalazau on 14.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
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

@end
