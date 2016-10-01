//
//  MeleeSystem.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/5/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "cocos2d.h"
#import "EntityManager.h"
#import "MeleeSystem.h"

@implementation MeleeSystem

- (void)update:(float)dt {
    NSArray *entities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[MeleeComponent class]];
    for (Entity *entity in entities) {

        RenderComponent *render = entity.render;
        TargetComponent *target = entity.target;
        MeleeComponent *melee = entity.melee;

        if (!render || !target || !melee) continue;

        if ([entity.render.node getActionByTag:ANIMATION_EFFECT] != nil) {
            continue;
        } else if (melee.count == 0) {
            [entity.render.node stopAllActions];
            [entity.render.node removeFromParentAndCleanup:YES];
            [self.entityManager removeEntity:entity];
            continue;
        }

        Entity *enemy = [self.entityManager getEntityByEid:target.eid];

        if (enemy.health.alive == NO) {
            [entity.render.node stopAllActions];
            [entity.render.node removeFromParentAndCleanup:YES];
            [self.entityManager removeEntity:entity];
            continue;
        }

        melee.count -= 1;
        render.node.position = enemy.render.node.position;

        int hp = enemy.health.current;
        enemy.health.current = enemy.health.current - melee.damage;
        hp = hp - enemy.health.current;
        [self showNumber:hp owner:enemy.render.node color:ccRED];

        id animation = [[CCAnimationCache sharedAnimationCache] animationByName:melee.animation];
        id animate = [CCAnimate actionWithAnimation:animation];
        [animate setTag:ANIMATION_EFFECT];
        [entity.render.node runAction:animate];

        if (melee.sound != nil) {

        }
    }
}

- (void)showNumber:(int)numb owner:(CCSprite *)owner color:(ccColor3B)c {
    float scale = 1.0;
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        scale = 0.7;
    }

    CCLabelBMFont *label = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%i", numb] fntFile:@"numbers.fnt"];
    label.color = c;
    label.position = ccp(owner.contentSize.width / 2, owner.contentSize.height / 2);

    label.scale = scale;

    [owner addChild:label z:TOP];

    id fadeIn = [CCFadeIn actionWithDuration:0.5f];
    id moveUp = [CCMoveTo actionWithDuration:0.5f position:ccp(owner.contentSize.width / 2, owner.contentSize.height)];
    id spawn = [CCSpawn actions:fadeIn, moveUp, nil];

    id cleanUp = [CCCallFuncN actionWithTarget:self selector:@selector(cleanNumber:)];

    id sequence = [CCSequence actionOne:spawn two:cleanUp];
    [label runAction:sequence];
}

- (void)cleanNumber:(id)node {
    [node removeFromParentAndCleanup:YES];
}

@end
