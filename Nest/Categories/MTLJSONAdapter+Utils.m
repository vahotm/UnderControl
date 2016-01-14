//
//  MTLJSONAdapter+Utils.m
//  Nest
//
//  Created by ivanSamalazau on 14.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "MTLJSONAdapter+Utils.h"

@implementation MTLJSONAdapter (Utils)

+ (NSDictionary *)nonNullJSONDictionaryFromModel:(id<MTLJSONSerializing>)model error:(NSError *__autoreleasing *)error
{
    NSDictionary *dictionary = [self JSONDictionaryFromModel:model error:error];
    NSMutableDictionary *nonNullDictionary = [NSMutableDictionary new];
    [dictionary enumerateKeysAndObjectsUsingBlock:
     ^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
         if (![obj isKindOfClass:[NSNull class]]) {
             nonNullDictionary[key] = obj;
         }
     }];
    return nonNullDictionary;
}

@end
