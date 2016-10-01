//
//  TargetComponent.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/6/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "Component.h"

@interface TargetComponent : Component

@property(assign) int eid;

- (id)initWithTargetEid:(int)eid;

@end
