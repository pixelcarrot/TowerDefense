//
//  CharacterSystem.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 3/7/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "cocos2d.h"
#import "EntityManager.h"
#import "EntityFactory.h"
#import "CharacterSystem.h"
#import "SimpleAudioEngine.h"

@implementation CharacterSystem

- (void)cleanup:(id)node {
    CCSprite *sprite = node;
    if (sprite.tag == 2) {
        Global_Monster_Counter--;
        //play sound
        [[SimpleAudioEngine sharedEngine] playEffect:@"coin.wav" pitch:1.0f pan:0 gain:0.9];
        [self.entityFactory createCandyWithPosition:sprite.position];
    }
    [node removeFromParentAndCleanup:YES];
}

- (void)update:(float)dt {
    NSArray *entities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[CharacterComponent class]];
    for (Entity *entity in entities) {

        CharacterComponent *character = entity.character;
        RenderComponent *render = entity.render;
        GridComponent *grid = entity.grid;
        TeamComponent *team = entity.team;
        RadarComponent *radar = entity.radar;
        TargetComponent *target = entity.target;
        HealthComponent *health = entity.health;
        WeaponComponent *weapon = entity.weapon;
        MoveComponent *move = entity.move;
        if (!render || !grid || !team || !radar || !target || !health || !weapon) continue;

        if (grid.isOut == YES) {
            [render.node removeFromParentAndCleanup:YES];
            [self.entityManager removeEntity:entity];

            continue;
        }

        if (health.alive == NO) {

            [render.node stopAllActions];

            CCSprite *sprite = render.node;
            sprite.tag = team.team;

            [self.entityManager removeEntity:entity];

            id animation;
            switch (grid.dir) {
                case SW:
                case SE:
                    animation = [[CCAnimationCache sharedAnimationCache] animationByName:
                            [NSString stringWithFormat:@"%@_die1", character.name]];
                    break;
                case NE:
                case NW:
                    animation = [[CCAnimationCache sharedAnimationCache] animationByName:
                            [NSString stringWithFormat:@"%@_die2", character.name]];
                    break;

                default:
                    break;
            }
            id animate = [CCAnimate actionWithAnimation:animation];
            id cleanup = [CCCallFuncN actionWithTarget:self selector:@selector(cleanup:)];
            id sequence = [CCSequence actionOne:animate two:cleanup];

            [sequence setTag:ANIMATION_DIE];
            [sprite runAction:sequence];

            //play sound
            [[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"die_%@.wav", character.name]
                                                   pitch:1.0f
                                                     pan:0
                                                    gain:0.9];

            continue;
        }

        if (target.eid < 0) {

            if (team.team == 1 && [render.node getActionByTag:ANIMATION_IDLE] == nil) {

                id animation;
                switch (grid.dir) {
                    case SW:
                    case SE:
                        animation = [[CCAnimationCache sharedAnimationCache] animationByName:
                                [NSString stringWithFormat:@"%@_idle1", character.name]];
                        break;
                    case NE:
                    case NW:
                        animation = [[CCAnimationCache sharedAnimationCache] animationByName:
                                [NSString stringWithFormat:@"%@_idle2", character.name]];
                        break;

                    default:
                        break;
                }
                id animate = [CCAnimate actionWithAnimation:animation];
                id speed = [CCSpeed actionWithAction:animate speed:1.5f];

                [speed setTag:ANIMATION_IDLE];
                [render.node runAction:speed];

                continue;
            }

            if (team.team == 2 && move.allow == NO) {
                move.allow = YES;
                /*
                if ([render.node getActionByTag:ANIMATION_IDLE] == nil) {
                    
                    id animation;
                    switch (grid.dir) {
                        case SW: case SE:
                            animation = [[CCAnimationCache sharedAnimationCache] animationByName:
                                         [NSString stringWithFormat:@"%@_idle1", name.name]];
                            break;
                        case NE: case NW:
                            animation = [[CCAnimationCache sharedAnimationCache] animationByName:
                                         [NSString stringWithFormat:@"%@_idle2", name.name]];
                            break;
                            
                        default:
                            break;
                    }
                    id animate = [CCAnimate actionWithAnimation:animation];
                    id speed = [CCSpeed actionWithAction:animate speed:1.5f];
                    
                    [speed setTag:ANIMATION_IDLE];
                    [render.node runAction:speed];
                }
                
                continue;*/
            }

            if (team.team == 2 && [render.node getActionByTag:ANIMATION_MOVE] == nil) {
                move.allow = YES;
                id animation;
                switch (grid.dir) {
                    case SW:
                    case SE:
                        animation = [[CCAnimationCache sharedAnimationCache] animationByName:
                                [NSString stringWithFormat:@"%@_move1", character.name]];
                        break;
                    case NE:
                    case NW:
                        animation = [[CCAnimationCache sharedAnimationCache] animationByName:
                                [NSString stringWithFormat:@"%@_move2", character.name]];
                        break;

                    default:
                        break;
                }
                id animate = [CCAnimate actionWithAnimation:animation];
                id speed = [CCSpeed actionWithAction:animate speed:move.speed];

                [speed setTag:ANIMATION_MOVE];
                [render.node runAction:speed];

                continue;
            }

        } else if ([render.node getActionByTag:ANIMATION_ATTACK] == nil) {

            Entity *enemy = [self.entityManager getEntityByEid:target.eid];
            //target.eid = -1;

            if (enemy == nil) {
                target.eid = -1;
                weapon.allow = NO;
                continue;
            }

            if (enemy.health.alive == NO) {
                target.eid = -1;
                weapon.allow = NO;
                continue;
            }

            if (weapon.allow == YES) {

                switch (weapon.weapon) {
                    case Bow: {

                        //play sound
                        [[SimpleAudioEngine sharedEngine] playEffect:@"atk_bow.wav" pitch:1.0f pan:0 gain:0.9];

                        Entity *arrow = [self.entityFactory createArrowWithTeam:team.team targetEid:enemy.eid damage:weapon.damage row:grid.row col:grid.col];
                        arrow.render.node.zOrder = 99;
                        arrow.render.node.position = entity.render.node.position;
                        arrow.move.angle = [self fixArrow:arrow.render.node direction:grid.dir];
                    }
                        break;

                    case Canon: {

                        //play sound
                        [[SimpleAudioEngine sharedEngine] playEffect:@"atk_canon.wav" pitch:1.0f pan:0 gain:0.9];

                        Entity *slug = [self.entityFactory createSlugWithTeam:team.team targetEid:enemy.eid damage:weapon.damage row:grid.row col:grid.col];
                        slug.render.node.zOrder = 99;
                        slug.render.node.position = entity.render.node.position;
                    }
                        break;

                    case Rifle: {

                        //play sound
                        [[SimpleAudioEngine sharedEngine] playEffect:@"atk_rifle.wav" pitch:1.0f pan:0 gain:0.9];

                        Entity *bullet = [self.entityFactory createBulletWithTeam:team.team targetEid:enemy.eid damage:weapon.damage row:grid.row col:grid.col];
                        bullet.render.node.zOrder = 99;
                        bullet.render.node.position = entity.render.node.position;
                        [self fixBullet:bullet.render.node direction:grid.dir];
                    }
                        break;

                    case Staff: {

                        //play sound
                        [[SimpleAudioEngine sharedEngine] playEffect:@"atk_electric.wav" pitch:1.0f pan:0 gain:0.9];

                        Entity *ball = [self.entityFactory createElectricBallWithTeam:team.team targetEid:enemy.eid damage:weapon.damage row:grid.row col:grid.col];
                        ball.render.node.zOrder = 99;
                        ball.render.node.position = entity.render.node.position;
                    }
                        break;


                    case Poison: {

                        //play sound
                        [[SimpleAudioEngine sharedEngine] playEffect:@"atk_poison.wav" pitch:1.0f pan:0 gain:0.9];

                        Entity *ball = [self.entityFactory createPoisonBallWithTeam:team.team targetEid:enemy.eid damage:weapon.damage row:grid.row col:grid.col];
                        ball.render.node.zOrder = 99;
                        ball.render.node.position = entity.render.node.position;
                        ball.move.angle = [self fixArrow:ball.render.node direction:grid.dir];
                    }
                        break;

                    case Blade: {

                        //play sound
                        [[SimpleAudioEngine sharedEngine] playEffect:@"hit_blade.wav" pitch:1.0f pan:0 gain:0.9];

                        [self.entityFactory createDamage:weapon.damage targetEid:enemy.eid animation:@"hitBlade"];
                    }
                        break;

                    case Katana: {

                        //play sound
                        [[SimpleAudioEngine sharedEngine] playEffect:@"hit_katana.wav" pitch:1.0f pan:0 gain:0.9];

                        [self.entityFactory createDamage:weapon.damage targetEid:enemy.eid animation:@"hitKatana"];
                    }
                        break;

                    case Hammer: {

                        //play sound
                        [[SimpleAudioEngine sharedEngine] playEffect:@"hit_hammer.wav" pitch:1.0f pan:0 gain:0.9];

                        [self.entityFactory createDamage:weapon.damage targetEid:enemy.eid animation:@"hitHammer"];
                    }
                        break;

                    case Sword: {

                        //play sound
                        [[SimpleAudioEngine sharedEngine] playEffect:@"hit_sword.wav" pitch:1.0f pan:0 gain:0.9];

                        [self.entityFactory createDamage:weapon.damage targetEid:enemy.eid animation:@"hitSword"];
                    }
                        break;

                    case Bite: {
                        [self.entityFactory createDamage:weapon.damage targetEid:enemy.eid animation:@"hitHammer"];
                    }
                        break;

                    default:
                        break;
                }

                target.eid = -1;
                weapon.allow = NO;
                continue;
            }

            weapon.allow = YES;

            if (team.team == 1) {
                [render.node stopActionByTag:ANIMATION_IDLE];
            } else {
                move.allow = NO;
                [render.node stopActionByTag:ANIMATION_MOVE];
            }

            id animation;
            switch (grid.dir) {
                case SW:
                case SE:
                    animation = [[CCAnimationCache sharedAnimationCache] animationByName:
                            [NSString stringWithFormat:@"%@_attack1", character.name]];
                    break;
                case NE:
                case NW:
                    animation = [[CCAnimationCache sharedAnimationCache] animationByName:
                            [NSString stringWithFormat:@"%@_attack2", character.name]];
                    break;

                default:
                    break;
            }
            id animate = [CCAnimate actionWithAnimation:animation];
            id speed = [CCSpeed actionWithAction:animate speed:weapon.speed];
            [speed setTag:ANIMATION_ATTACK];
            [render.node runAction:speed];
        }
    }
}

- (void)fixBullet:(CCSprite *)sprite direction:(Direction)dir {
    switch (dir) {
        case SW:
            sprite.flipX = NO;
            sprite.rotation = -30;
            break;

        case SE:
            sprite.flipX = YES;
            sprite.rotation = 30;
            break;

        case NW:
            sprite.flipX = NO;
            sprite.rotation = 0;
            break;

        case NE:
            sprite.flipX = YES;
            sprite.rotation = 0;
            break;

        default:
            break;
    }
}

- (int)fixArrow:(CCSprite *)sprite direction:(Direction)dir {
    int angle = 0;

    switch (dir) {
        case SW:
            sprite.flipX = NO;
            sprite.anchorPoint = ccp(0, 0.5);
            sprite.rotation = 0;
            angle = -30;
            sprite.position = ccp(sprite.position.x - 30, sprite.position.y);
            break;

        case SE:
            sprite.flipX = YES;
            sprite.anchorPoint = ccp(1, 0.5);
            sprite.rotation = 0;
            angle = 30;
            sprite.position = ccp(sprite.position.x + 30, sprite.position.y);
            break;

        case NW:
            sprite.flipX = NO;
            sprite.anchorPoint = ccp(0, 0.5);
            sprite.rotation = 30;
            angle = 0;
            sprite.position = ccp(sprite.position.x - 30, sprite.position.y);
            break;

        case NE:
            sprite.flipX = YES;
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
