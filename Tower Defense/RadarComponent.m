//
//  RadarComponent.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/4/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "RadarComponent.h"

@implementation RadarComponent

- (id)initWithRange:(int)range {
    if ((self = [super init])) {
        self.range = range;
        self.delay = 0;
        self.elapsed = 0;
    }
    return self;
}

- (id)initWithRange:(int)range delay:(float)delay {
    if ((self = [super init])) {
        self.range = range;
        self.delay = delay;
        self.elapsed = delay;
    }
    return self;
}


@end
