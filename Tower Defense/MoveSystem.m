//
//  MoveSystem.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/2/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "cocos2d.h"
#import "EntityManager.h"
#import "EntityFactory.h"
#import "MoveSystem.h"
#import "SimpleAudioEngine.h"

@implementation MoveSystem

- (void)update:(float)dt {
    NSArray *entities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[MoveComponent class]];
    for (Entity *entity in entities) {

        RenderComponent *render = entity.render;
        MoveComponent *move = entity.move;
        TargetComponent *target = entity.target;
        WeaponComponent *weapon = entity.weapon;

        if (!render || !move) continue;

        /*
        DelayComponent * delay = entity.delay;
        if (delay != nil) {
            delay.delay -= dt;
            if (delay.delay > 0) {
                continue;
            }
            [self.entityManager removeComponent:delay fromEntity:entity];
        } */

        if (move.allow == YES) {

            if (render.node.position.x == move.target.x && render.node.position.y == move.target.y) {
                move.allow = NO;

                if (weapon && target) {
                    switch (weapon.weapon) {
                        case Arrow:

                            //play sound
                            [[SimpleAudioEngine sharedEngine] playEffect:@"hit_arrow.wav" pitch:1.0f pan:0 gain:0.9];

                            [self.entityFactory createDamage:entity.weapon.damage targetEid:target.eid animation:@"hitArrow"];
                            break;

                        case Slug:

                            //play sound
                            [[SimpleAudioEngine sharedEngine] playEffect:@"hit_fire.wav" pitch:1.0f pan:0 gain:0.9];

                            [self.entityFactory createDamage:entity.weapon.damage targetEid:target.eid animation:@"hitCanon"];
                            break;

                        case Bullet:

                            //play sound
                            [[SimpleAudioEngine sharedEngine] playEffect:@"hit_bullet.wav" pitch:1.0f pan:0 gain:0.9];

                            [self.entityFactory createDamage:entity.weapon.damage targetEid:target.eid animation:@"hitBullet"];
                            break;

                        case Electric:

                            //play sound
                            [[SimpleAudioEngine sharedEngine] playEffect:@"hit_electric.wav" pitch:1.0f pan:0 gain:0.9];

                            [self.entityFactory createDamage:entity.weapon.damage targetEid:target.eid animation:@"hitElectric"];
                            break;

                        case Poison:

                            //play sound
                            [[SimpleAudioEngine sharedEngine] playEffect:@"hit_ice.wav" pitch:1.0f pan:0 gain:0.9];

                            [self.entityFactory createDamage:entity.weapon.damage targetEid:target.eid animation:@"hitPoison"];
                            break;

                        default:
                            break;
                    }
                }

                [entity.render.node stopAllActions];
                [entity.render.node removeFromParentAndCleanup:YES];
                [self.entityManager removeEntity:entity];
                continue;
            }

            if ([render.node getActionByTag:MOVE] == nil) {

                switch (move.type) {
                    case JumpTo: {

                        float duration = ccpDistance(render.node.position, move.target) / move.speed;
                        id shoot = [CCSpawn actions:
                                [CCJumpTo actionWithDuration:duration position:move.target height:15 jumps:1],
                                [CCRotateTo actionWithDuration:duration angle:move.angle],
                                        nil];
                        [shoot setTag:MOVE];
                        [entity.render.node runAction:shoot];
                    }
                        break;

                    case MoveTo: {

                        float duration = ccpDistance(render.node.position, move.target) / move.speed;
                        id shoot = [CCMoveTo actionWithDuration:duration position:move.target];
                        [shoot setTag:MOVE];
                        [entity.render.node runAction:shoot];
                    }
                        break;

                    case MoveBy: {

                        id run = [CCMoveBy actionWithDuration:1.f position:move.target];
                        id speed = [CCSpeed actionWithAction:run speed:move.speed];
                        [speed setTag:MOVE];
                        [render.node runAction:speed];
                    }
                        break;

                    default:
                        break;
                }
            }

        } else {
            [render.node stopActionByTag:MOVE];
        }
    }
}

- (int)fixArrow:(CCSprite *)sprite direction:(Direction)dir {
    int angle = 0;

    switch (dir) {
        case SW:
            sprite.flipX = YES;
            sprite.anchorPoint = ccp(0, 0.5);
            sprite.rotation = 0;
            angle = -30;
            sprite.position = ccp(sprite.position.x - 30, sprite.position.y);
            break;

        case SE:
            sprite.flipX = NO;
            sprite.anchorPoint = ccp(1, 0.5);
            sprite.rotation = 0;
            angle = 30;
            sprite.position = ccp(sprite.position.x + 30, sprite.position.y);
            break;

        case NW:
            sprite.flipX = YES;
            sprite.anchorPoint = ccp(0, 0.5);
            sprite.rotation = 30;
            angle = 0;
            sprite.position = ccp(sprite.position.x - 30, sprite.position.y);
            break;

        case NE:
            sprite.flipX = NO;
            sprite.anchorPoint = ccp(1, 0.5);
            sprite.rotation = -30;
            angle = 0;
            sprite.position = ccp(sprite.position.x + 30, sprite.position.y);
            break;

        default:
            break;
    }

    return angle;
}

@end
