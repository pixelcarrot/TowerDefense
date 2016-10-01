//
//  MoneyComponent.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 3/7/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "MoneyComponent.h"

@implementation MoneyComponent

- (id)initWithValue:(int)value {
    if ((self = [super init])) {
        self.value = value;
    }
    return self;
}

@end
