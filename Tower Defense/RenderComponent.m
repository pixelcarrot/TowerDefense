//
//  RenderComponent.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/30/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "RenderComponent.h"

@implementation RenderComponent

- (id)initWithNode:(CCSprite *)node {
    if ((self = [super init])) {
        self.node = node;
    }
    return self;
}

@end