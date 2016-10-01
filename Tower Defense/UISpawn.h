//
//  UISpawn.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 3/8/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "CCSprite.h"

@interface UISpawn : CCSprite

@property(unsafe_unretained) NSString *name;

- (id)initWithName:(NSString *)name;

@end
