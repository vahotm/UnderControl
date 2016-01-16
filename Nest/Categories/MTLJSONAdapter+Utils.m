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

+ (NSArray *)modelsOfClass:(Class)modelClass fromJSONPseudoArray:(NSDictionary *)pseudoArray error:(NSError **)error
{
    *error = nil;
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *key in [pseudoArray allKeys]) {
        NSDictionary *dict = pseudoArray[key];
        id model = [self modelOfClass:modelClass
                   fromJSONDictionary:dict
                                error:error];
        NSAssert(*error == nil, @"%@", [*error localizedDescription]);
        if (*error != nil) {
            return nil;
        }
        else {
            [array addObject:model];
        }
    }
    return array;
}

+ (NSDictionary *)JSONPseudoArrayFromModels:(NSArray *)models idKeyPath:(NSString *)idKeyPath error:(NSError *__autoreleasing *)error
{
    *error = nil;
    NSMutableDictionary *pseudoArray = [NSMutableDictionary dictionary];
    
    for (id<MTLJSONSerializing> model in models) {
        
        NSDictionary *dict = [self JSONDictionaryFromModel:model
                                                     error:error];
        NSAssert(*error == nil, @"%@", [*error localizedDescription]);
        if (*error != nil) {
            return nil;
        }
        else {
            NSString *key = dict[idKeyPath];
            [pseudoArray setObject:dict
                            forKey:key];
        }
    }
    return pseudoArray;
}

+ (MTLValueTransformer *)pseudoArrayTransformerWithModelClass:(Class)modelClass idKeyPath:(NSString *)idKeyPath
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelsOfClass:modelClass
                         fromJSONPseudoArray:value
                                       error:error];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter JSONPseudoArrayFromModels:value
                                               idKeyPath:idKeyPath
                                                   error:error];
    }];
}

@end
