//
//  Metadata.h
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "BaseModel.h"

@interface Metadata : BaseModel

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, assign) NSInteger clientVersion;

@end
