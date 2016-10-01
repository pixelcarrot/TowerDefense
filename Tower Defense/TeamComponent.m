//
//  TeamComponent.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/31/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "TeamComponent.h"

@implementation TeamComponent

- (id)initWithTeam:(int)team {
    if ((self = [super init])) {
        self.team = team;
    }
    return self;
}

@end

