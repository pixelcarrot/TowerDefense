//
//  MoveComponent.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/31/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "MoveComponent.h"

@implementation MoveComponent

- (id)initWithMoveTarget:(CGPoint)target speed:(float)speed type:(MoveType)type {
    if ((self = [super init])) {
        self.target = target;
        self.speed = speed;
        self.allow = YES;
        self.type = type;
    }
    return self;
}

@end
