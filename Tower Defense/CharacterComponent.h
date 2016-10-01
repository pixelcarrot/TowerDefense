//
//  CharacterComponent.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 3/7/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "Component.h"

@interface CharacterComponent : Component

@property(unsafe_unretained) NSString *name;

- (id)initWithName:(NSString *)name;

@end
