//
//  TTLComponent.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 3/9/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "Component.h"

@interface TTLComponent : Component

@property(assign) float time;

- (id)initWithTTL:(float)time;

@end
