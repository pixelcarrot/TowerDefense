//
//  GridComponent.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/31/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "GridComponent.h"

@implementation GridComponent

- (id)initWithRow:(int)row col:(int)col direction:(Direction)dir {
    if ((self = [super init])) {
        self.row = row;
        self.col = col;
        self.dir = dir;
        self.isOut = NO;
    }
    return self;
}

@end
