//
//  MoveComponent.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/31/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "Component.h"

typedef enum {
    MoveBy, MoveTo, JumpTo
} MoveType;

@interface MoveComponent : Component

@property(assign) MoveType type;
@property(assign) CGPoint target;
@property(assign) float speed;
@property(assign) float angle;
@property(assign) BOOL allow;

- (id)initWithMoveTarget:(CGPoint)target speed:(float)speed type:(MoveType)type;

@end
