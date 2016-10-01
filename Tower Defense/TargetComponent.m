//
//  TargetComponent.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/6/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "TargetComponent.h"

@implementation TargetComponent

- (id)initWithTargetEid:(int)eid {
    if ((self = [super init])) {
        self.eid = eid;
    }
    return self;
}

@end
