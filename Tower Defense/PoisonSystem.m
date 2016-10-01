//
//  PoisonSystem.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/9/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "cocos2d.h"
#import "EntityManager.h"
#import "EntityFactory.h"
#import "PoisonSystem.h"

@implementation PoisonSystem

- (void)update:(float)dt {
    NSArray *entities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[PoisonComponent class]];
    for (Entity *entity in entities) {

        RenderComponent *render = entity.render;
        PoisonComponent *poison = entity.poison;
        HealthComponent *health = entity.health;

        if (!render || !poison || !health) continue;

        if (health.alive == NO) {
            continue;
        }

        // important !!
        poison.delay = poison.delay - dt;
        if (poison.delay > 0) {
            continue;
        }

        poison.cooldown = poison.cooldown - dt;
        if (poison.cooldown < 0) {
            [self.entityManager removeComponent:entity.poison fromEntity:entity];
            continue;
        }

        if ([render.node getChildByTag:POISON] != nil) {
            continue;
        }

        CCSprite *sprite = [CCSprite node];
        sprite.position = ccp(render.node.contentSize.width / 2, render.node.contentSize.height);
        [render.node addChild:sprite z:TOP tag:POISON];

        id animation = [[CCAnimationCache sharedAnimationCache] animationByName:poison.animation];
        id animate = [CCAnimate actionWithAnimation:animation];
        id cleanup = [CCCallFuncN actionWithTarget:self selector:@selector(cleanup:)];
        id sequence = [CCSequence actionOne:animate two:cleanup];
        [sequence setTag:ANIMATION_SPELL];

        [sprite runAction:sequence];

        [self.entityFactory createDamage:5 targetEid:entity.eid animation:nil];
    }
}

- (void)cleanup:(id)node {
    [node removeFromParentAndCleanup:YES];
}

@end
