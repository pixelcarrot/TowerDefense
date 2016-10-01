//
//  PoisonComponent.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/9/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "Component.h"

@interface PoisonComponent : Component

@property(assign) float delay;
@property(assign) float cooldown;
@property(unsafe_unretained) NSString *animation;

- (id)initWithCooldown:(float)cooldown delay:(float)delay animation:(NSString *)animation;

@end
