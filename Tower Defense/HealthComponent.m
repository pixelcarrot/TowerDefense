//
//  HealthComponent.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/31/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "HealthComponent.h"

@implementation HealthComponent

@synthesize current = _current;
@synthesize max = _max;

- (id)initWithCurHp:(float)curHp maxHp:(float)maxHp {
    if ((self = [super init])) {
        self.max = maxHp; // important
        self.current = curHp;
    }
    return self;
}

- (BOOL)alive {
    return _current > 0 ? YES : NO;
}

- (float)percentage {
    return _current * 100.f / _max;
}

- (void)setCurrent:(float)value {
    if (value < 0) {
        _current = 0;
    } else if (value > _max) {
        _current = _max;
    } else {
        _current = value;
    }
}

- (float)current {
    return _current;
}

- (void)setMax:(float)value {
    if (value < 0) {
        _max = 0;
    } else {
        _max = value;
    }
}

- (float)max {
    return _max;
}

@end
