//
//  MTLJSONAdapter+Utils.h
//  Nest
//
//  Created by ivanSamalazau on 14.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MTLJSONAdapter (Utils)

+ (NSDictionary *)nonNullJSONDictionaryFromModel:(id<MTLJSONSerializing>)model
                                           error:(NSError *__autoreleasing *)error;

+ (NSArray *)modelsOfClass:(Class)modelClass
       fromJSONPseudoArray:(NSDictionary *)pseudoArray
                     error:(NSError **)error;
+ (NSDictionary *)JSONPseudoArrayFromModels:(NSArray *)models
                                  idKeyPath:(NSString *)idKeyPath
                                      error:(NSError *__autoreleasing *)error;

+ (MTLValueTransformer *)pseudoArrayTransformerWithModelClass:(Class)modelClass idKeyPath:(NSString *)idKeyPath;

@end
