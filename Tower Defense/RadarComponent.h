//
//  RadarComponent.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/4/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "Component.h"

@interface RadarComponent : Component

@property(assign) int range;
@property(assign) float delay;
@property(assign) float elapsed;

- (id)initWithRange:(int)range;

- (id)initWithRange:(int)range delay:(float)delay;

@end
