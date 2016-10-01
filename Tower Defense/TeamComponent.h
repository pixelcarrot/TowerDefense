//
//  TeamComponent.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/31/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "Component.h"

@interface TeamComponent : Component

@property(assign) int team;

- (id)initWithTeam:(int)team;

@end