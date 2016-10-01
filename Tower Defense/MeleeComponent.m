//
//  MeleeComponent.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/1/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "MeleeComponent.h"

@implementation MeleeComponent

@synthesize count = _count;

- (id)initWithDamage:(float)damage animation:(NSString *)animation sound:(NSString *)sound {
    if ((self = [super init])) {
        self.damage = damage;
        self.count = 1;
        self.animation = animation;
        self.sound = sound;
    }
    return self;
}

- (id)initWithDamage:(float)damage count:(int)count animation:(NSString *)animation sound:(NSString *)sound {
    if ((self = [super init])) {
        self.damage = damage;
        self.count = count;
        self.animation = animation;
        self.sound = sound;
    }
    return self;
}

- (void)setCount:(int)value {
    if (value < 0) {
        _count = 0;
    } else {
        _count = value;
    }
}

- (int)count {
    return _count;
}

@end
