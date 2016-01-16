//
//  State.h
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "BaseModel.h"


@class Metadata;
@class Structure;
@class Devices;
@interface State : BaseModel

@property (nonatomic, strong) Metadata *metadata;
@property (nonatomic, strong) Devices *devices;
@property (nonatomic, strong) NSArray<Structure *> *structures;

@end
