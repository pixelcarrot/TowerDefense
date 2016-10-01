//
//  CharacterComponent.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 3/7/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "CharacterComponent.h"

@implementation CharacterComponent

- (id)initWithName:(NSString *)name {
    if ((self = [super init])) {
        self.name = name;
    }
    return self;
}

@end
