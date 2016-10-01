//
//  EntityFactory.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/30/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "cocos2d.h"
#import "EntityFactory.h"
#import "EntityManager.h"

@implementation EntityFactory {
    EntityManager *_entityManager;
    CCLayer *_layer;
}

- (id)initWithEntityManager:(EntityManager *)entityManager layer:(CCLayer *)layer {
    if ((self = [super init])) {
        _entityManager = entityManager;
        _layer = layer;
    }
    return self;
}

- (Entity *)createCandyWithPosition:(CGPoint)pos {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"candy.png"];
    [_layer addChild:sprite z:TOP];
    sprite.position = pos;

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[TTLComponent alloc] initWithTTL:5.f] toEntity:entity];
    [_entityManager addComponent:[[MoneyComponent alloc] init] toEntity:entity];

    return entity;
}

- (Entity *)createDamage:(int)damage targetEid:(int)eid animation:(NSString *)animation {
    CCSprite *sprite = [CCSprite node];
    [_layer addChild:sprite z:TOP];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:eid] toEntity:entity];
    [_entityManager addComponent:[[MeleeComponent alloc] initWithDamage:damage animation:animation sound:nil] toEntity:entity];

    return entity;
}

- (Entity *)createBulletWithTeam:(int)team targetEid:(int)eid damage:(int)damage row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"bullet.png"];
    [_layer addChild:sprite];

    Entity *target = [_entityManager getEntityByEid:eid];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:target.render.node.position speed:400.f type:MoveTo] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:eid] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bullet damage:damage speed:0.f] toEntity:entity];
    return entity;
}

- (Entity *)createSlugWithTeam:(int)team targetEid:(int)eid damage:(int)damage row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"slug.png"];
    [_layer addChild:sprite];

    Entity *target = [_entityManager getEntityByEid:eid];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:target.render.node.position speed:400.f type:JumpTo] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:eid] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Slug damage:damage speed:0.f] toEntity:entity];
    return entity;
}

- (Entity *)createArrowWithTeam:(int)team targetEid:(int)eid damage:(int)damage row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"arrow.png"];
    [_layer addChild:sprite];

    Entity *target = [_entityManager getEntityByEid:eid];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:target.render.node.position speed:400.f type:JumpTo] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:eid] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Arrow damage:damage speed:0.f] toEntity:entity];
    return entity;
}

- (Entity *)createElectricBallWithTeam:(int)team targetEid:(int)eid damage:(int)damage row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite node];
    id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"electricBall"];
    id animate = [CCAnimate actionWithAnimation:animation];
    [sprite runAction:[CCRepeatForever actionWithAction:animate]];
    [_layer addChild:sprite];

    Entity *target = [_entityManager getEntityByEid:eid];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:target.render.node.position speed:400.f type:JumpTo] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:eid] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Electric damage:damage speed:0.f] toEntity:entity];
    return entity;
}

- (Entity *)createPoisonBallWithTeam:(int)team targetEid:(int)eid damage:(int)damage row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite node];
    id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"poisonBall"];
    id animate = [CCAnimate actionWithAnimation:animation];
    [sprite runAction:[CCRepeatForever actionWithAction:animate]];
    [_layer addChild:sprite];

    Entity *target = [_entityManager getEntityByEid:eid];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:target.render.node.position speed:400.f type:JumpTo] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:eid] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Poison damage:damage speed:0.f] toEntity:entity];
    return entity;
}

- (Entity *)createAlchemistWithTeam:(int)team row:(int)row col:(int)col {

    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_blue_idl_%.2i.png", @"alchemist", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:80 maxHp:80] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"alchemist"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Poison damage:10 speed:0.7f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:9] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
    }
    return entity;
}

- (Entity *)createArcherWithTeam:(int)team row:(int)row col:(int)col {

    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_blue_idl_%.2i.png", @"archer", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:80 maxHp:80] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"archer"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bow damage:10 speed:2.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:9] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
    }
    return entity;
}

- (Entity *)createAssassinWithTeam:(int)team row:(int)row col:(int)col {

    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_blue_idl_%.2i.png", @"assassin", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:150 maxHp:150] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"assassin"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Blade damage:10 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
    }
    return entity;
}

- (Entity *)createCannoneerWithTeam:(int)team row:(int)row col:(int)col {

    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_blue_idl_%.2i.png", @"cannoneer", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:80 maxHp:80] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"cannoneer"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Canon damage:30 speed:0.8f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:9 delay:1.5f] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
    }
    return entity;
}

- (Entity *)createKnightWithTeam:(int)team row:(int)row col:(int)col {

    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_blue_idl_%.2i.png", @"knight", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:200 maxHp:200] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"knight"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Sword damage:10 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
    }
    return entity;
}

- (Entity *)createNinjaWithTeam:(int)team row:(int)row col:(int)col {

    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_blue_idl_%.2i.png", @"ninja", 25]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:150 maxHp:150] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"ninja"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Katana damage:20 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
    }
    return entity;
}

- (Entity *)createPaladinWithTeam:(int)team row:(int)row col:(int)col {

    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_blue_idl_%.2i.png", @"paladin", 25]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:300 maxHp:300] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"paladin"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Hammer damage:10 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
    }
    return entity;
}

- (Entity *)createScoutWithTeam:(int)team row:(int)row col:(int)col {

    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_blue_idl_%.2i.png", @"scout", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:80 maxHp:80] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"scout"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bow damage:20 speed:0.9f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:9 delay:1.f] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
    }
    return entity;
}

- (Entity *)createSniperWithTeam:(int)team row:(int)row col:(int)col {

    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_blue_idl_%.2i.png", @"sniper", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:80 maxHp:80] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"sniper"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Rifle damage:50 speed:0.9f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:9 delay:2.f] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
    }
    return entity;
}

- (Entity *)createSoldierWithTeam:(int)team row:(int)row col:(int)col {

    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_blue_idl_%.2i.png", @"soldier", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:150 maxHp:150] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"soldier"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Sword damage:10 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
    }
    return entity;
}

- (Entity *)createWarriorWithTeam:(int)team row:(int)row col:(int)col {

    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_blue_idl_%.2i.png", @"warrior", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:200 maxHp:200] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"warrior"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Sword damage:10 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
    }
    return entity;
}


- (Entity *)createSorcererWithTeam:(int)team row:(int)row col:(int)col {

    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_blue_idl_%.2i.png", @"sorcerer", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:80 maxHp:80] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"sorcerer"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Staff damage:10 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:9] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
    }
    return entity;
}

// khởi tạo monsters
- (Entity *)createArmorSkeletonWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"armorSkeleton", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"armorSkeleton"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Hammer damage:10 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1 delay:0.5f] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createBatWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"bat", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"bat"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:5 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createBeezManWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"beezMan", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"beezMan"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:10 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createBehemothWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"behemoth", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:200 maxHp:200] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"behemoth"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:20 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createChimeraWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"chimera", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:150 maxHp:150] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"chimera"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:20 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createCockatriceWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"cockatrice", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:150 maxHp:150] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"cockatrice"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:20 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createDevilManWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"devilMan", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:200 maxHp:200] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"devilMan"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:20 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createDruidWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"druid", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:150 maxHp:150] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"druid"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Blade damage:20 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createGargoyleWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"gargoyle", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:200 maxHp:200] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"gargoyle"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:20 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createGigantesWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"gigantes", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:200 maxHp:200] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"gigantes"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Sword damage:20 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createGoblinWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"goblin", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"goblin"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Sword damage:5 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createGremlinWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"gremlin", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"gremlin"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:5 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createHarpyWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"harpy", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"harpy"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:10 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createHurricanoWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"hurricano", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"hurricano"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:15 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createKentaurosWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"kentauros", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"kentauros"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Sword damage:15 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createLilithWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"lilith", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"lilith"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:15 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createManticoreWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"manticore", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"manticore"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:15 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createScolpionWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"scolpion", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"scolpion"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:15 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createSkeletonWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"skeleton", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"skeleton"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Hammer damage:15 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createSnowManWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"snowMan", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"snowMan"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:15 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createTentaclesWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"tentacles", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"tentacles"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Poison damage:15 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:9] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createWarLionWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"warLion", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"warLion"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:15 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

- (Entity *)createWarWolfWithTeam:(int)team row:(int)row col:(int)col {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", @"warWolf", 9]];
    [_layer addChild:sprite];

    Entity *entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurHp:100 maxHp:100] toEntity:entity];
    [_entityManager addComponent:[[MoveComponent alloc] initWithMoveTarget:ccp(0, 0) speed:1.5f type:MoveBy] toEntity:entity];
    [_entityManager addComponent:[[TeamComponent alloc] initWithTeam:team] toEntity:entity];
    [_entityManager addComponent:[[CharacterComponent alloc] initWithName:@"warWolf"] toEntity:entity];

    [_entityManager addComponent:[[WeaponComponent alloc] initWithWeapon:Bite damage:15 speed:1.f] toEntity:entity];

    [_entityManager addComponent:[[RadarComponent alloc] initWithRange:1] toEntity:entity];
    [_entityManager addComponent:[[TargetComponent alloc] initWithTargetEid:-1] toEntity:entity];
    if (team == 1) {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:SW] toEntity:entity];
        sprite.flipX = NO;
    } else {
        [_entityManager addComponent:[[GridComponent alloc] initWithRow:row col:col direction:NE] toEntity:entity];
        sprite.flipX = YES;
    }
    return entity;
}

@end
