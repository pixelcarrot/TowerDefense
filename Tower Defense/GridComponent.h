//
//  GridComponent.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/31/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "Component.h"

typedef enum {
    NE, SE, SW, NW
} Direction;

@interface GridComponent : Component

@property(assign) int row;
@property(assign) int col;
@property(assign) BOOL isOut;
@property(assign) Direction dir;

- (id)initWithRow:(int)row col:(int)col direction:(Direction)dir;

@end
