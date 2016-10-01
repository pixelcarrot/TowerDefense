//
//  HealthSystem.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/5/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "cocos2d.h"
#import "EntityManager.h"
#import "HealthSystem.h"

@implementation HealthSystem

- (void)update:(float)dt {
    NSArray *entities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[HealthComponent class]];
    for (Entity *entity in entities) {

        RenderComponent *render = entity.render;
        HealthComponent *health = entity.health;

        if ([render.node getChildByTag:2] != nil) {
            id hp = [render.node getChildByTag:2];
            [hp setPercentage:[health percentage]];
            continue;
        }

        if (health.alive == NO) {
            continue;
        }

        CCProgressTimer *healthBar;
        CCSprite *redbar = [CCSprite spriteWithSpriteFrameName:@"healthbar_red.png"];
        CCSprite *green = [CCSprite spriteWithSpriteFrameName:@"healthbar_green.png"];
        healthBar = [CCProgressTimer progressWithSprite:green];

        [healthBar setPosition:ccp(render.node.contentSize.width / 2, render.node.contentSize.height - 20)];
        [redbar setPosition:ccp(render.node.contentSize.width / 2, render.node.contentSize.height - 20)];
        healthBar.type = kCCProgressTimerTypeBar;
        healthBar.barChangeRate = ccp(1, 0);
        healthBar.midpoint = ccp(0.0, 0.0f);
        healthBar.percentage = 100;
        [render.node addChild:redbar z:1 tag:1];
        [render.node addChild:healthBar z:2 tag:2];
    }
}

@end
