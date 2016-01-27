//
//  AccessToken.h
//  Nest
//
//  Created by ivanSamalazau on 14.1.16.
//

#import "BaseModel.h"

@interface AccessToken : BaseModel

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSDate *expireDate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue;

- (BOOL)isValid;

@end
