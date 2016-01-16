//
//  DeviceLocation.h
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "BaseModel.h"

@interface DeviceLocation : BaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *whereId;

@end
