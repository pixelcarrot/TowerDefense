//
//  RenderComponent.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/30/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "Component.h"
#import "cocos2d.h"

@interface RenderComponent : Component

@property(strong) CCSprite *node;

- (id)initWithNode:(CCSprite *)node;

@end

