//
//  AuthManager.m
//  Nest
//
//  Created by ivanSamalazau on 14.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "AuthManager.h"
#import "AccessToken.h"
#import "MTLJSONAdapter+Utils.h"

#import <RequestUtils.h>
#import <AFNetworking.h>


NSString *const kClientId = @"c073fbf5-0dd3-4bba-9402-b0ea70ef48f2";
NSString *const kClientSecret = @"ZvTYUz4AOBN2ALJ9gvpnNxRG4";

NSString *const kState = @"com.scnSoft.Nest.auth.state";
NSString *const kGrantType = @"authorization_code";

NSString *const kAuthorizationEndpoint = @"https://home.nest.com/login/oauth2";
NSString *const kAccessTokenEndpoint = @"https://api.home.nest.com/oauth2/access_token";
NSString *const kRedirectUrl = @"https://scnsoft.com/UnderControl";

NSString *const kAccessTokenKey = @"AccessTokenKey";


@implementation AuthManager

+ (NSString *)clientId
{
    return kClientId;
}

+ (NSString *)clientSecret
{
    return kClientSecret;
}

+ (NSString *)authorizationURL
{
    NSDictionary *params = @{@"client_id" : kClientId,
                             @"state" : kState};
    NSString *query = [NSString URLQueryWithParameters:params];
    NSString *url = [kAuthorizationEndpoint stringByAppendingURLQuery:query];
    return url;
}

+ (NSString *)accessTokenURLWithAuthCode:(NSString *)code
{
    NSDictionary *params = @{@"code" : code,
                             @"client_id" : kClientId,
                             @"client_secret" : kClientSecret,
                             @"grant_type" : kGrantType};
    NSString *query = [NSString URLQueryWithParameters:params];
    NSString *url = [kAccessTokenEndpoint stringByAppendingURLQuery:query];
    return url;
}

+ (NSString *)redirectURL
{
    return kRedirectUrl;
}

+ (NSString *)state
{
    return kState;
}

//- (BOOL)isValidSession
//{
//    if ([self accessToken]) {
//        return true;
//    } else {
//        return false;
//    }
//}

#pragma mark - Request

- (void)requestAuthTokenWithSuccess:(void (^)(NSString *authToken))success failure:(void (^)(NSError *error))failure
{
    NSAssert(self.authCode, @"Auth code mustn't be nil");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *params = @{@"code" : self.authCode,
                             @"client_id" : kClientId,
                             @"client_secret" : kClientSecret,
                             @"grant_type" : kGrantType};
    [manager POST:kAccessTokenEndpoint
       parameters:params
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              AccessToken *accessToken = [[AccessToken alloc] initWithDictionary:responseObject];
              if (accessToken) {
                  [self setAccessToken:accessToken];
                  
                  if (success) {
                      success(nil);
                  }
              }
              else {
                  if (failure) {
                      failure(nil);
                  }
              }
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
              if (failure) {
                  failure(error);
              }
          }];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
//    NSDictionary *params = @ {@"user" :txtUserName, @"pwd" :txtPwd };
//    
//    
//    [manager POST:URL_SIGNIN parameters:params
//          success:^(AFHTTPRequestOperation *operation, id responseObject)
//    {
//        NSLog(@"JSON: %@", responseObject);
//    }
//          failure:
//     ^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"Error: %@", error);
//     }];
}

#pragma mark - Singletone implementation

static AuthManager *sharedInstance;

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

#pragma mark - Properties

- (AccessToken *)accessToken
{
    NSDictionary *tokenDict = [[NSUserDefaults standardUserDefaults] objectForKey:kAccessTokenKey];
    if (tokenDict) {
        NSError *error = nil;
        AccessToken *token = [MTLJSONAdapter modelOfClass:[AccessToken class]
                                       fromJSONDictionary:tokenDict
                                                    error:&error];
        NSAssert(token, @"%@", error.localizedDescription);
        return token;
    }
    return nil;
}

- (void)setAccessToken:(AccessToken *)accessToken
{
    if (accessToken == nil) {
        return;
    }
    
    NSError *error = nil;
    NSDictionary *tokenDict = [MTLJSONAdapter JSONDictionaryFromModel:accessToken error:&error];
    NSAssert(tokenDict, @"%@", error.localizedDescription);
    
    [[NSUserDefaults standardUserDefaults] setObject:tokenDict forKey:kAccessTokenKey];
}




@end
