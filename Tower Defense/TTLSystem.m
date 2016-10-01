//
//  TTLSystem.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 3/9/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "cocos2d.h"
#import "EntityManager.h"
#import "EntityFactory.h"
#import "TTLSystem.h"

@implementation TTLSystem

- (void)update:(float)dt {
    NSArray *entities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[TTLComponent class]];
    for (Entity *entity in entities) {

        TTLComponent *ttl = entity.ttl;
        RenderComponent *render = entity.render;

        ttl.time -= dt;
        if (ttl.time <= 0) {

            if (render != nil) {
                [render.node removeFromParentAndCleanup:YES];
            }

            [self.entityManager removeEntity:entity];
        }
    }
}

@end
