//
//  PoisonComponent.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/9/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "PoisonComponent.h"

@implementation PoisonComponent

- (id)initWithCooldown:(float)cooldown delay:(float)delay animation:(NSString *)animation {
    if ((self = [super init])) {
        self.cooldown = cooldown;
        self.delay = delay;
        self.animation = animation;
    }
    return self;
}

@end
