//
//  TTLComponent.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 3/9/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "TTLComponent.h"

@implementation TTLComponent

- (id)initWithTTL:(float)time {
    if ((self = [super init])) {
        self.time = time;
    }
    return self;
}

@end
