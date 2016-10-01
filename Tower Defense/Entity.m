//
//  Entity.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/30/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "Entity.h"
#import "EntityManager.h"

@implementation Entity {
    uint32_t _eid;
    EntityManager *_entityManager;
}

- (id)initWithEid:(uint32_t)eid entityManager:(EntityManager *)entityManager {
    if ((self = [super init])) {
        _eid = eid;
        _entityManager = entityManager;
    }
    return self;
}

- (uint32_t)eid {
    return _eid;
}

- (RenderComponent *)render {
    return (RenderComponent *) [_entityManager getComponentOfClass:[RenderComponent class] forEntity:self];
}

- (MoveComponent *)move {
    return (MoveComponent *) [_entityManager getComponentOfClass:[MoveComponent class] forEntity:self];
}

- (HealthComponent *)health {
    return (HealthComponent *) [_entityManager getComponentOfClass:[HealthComponent class] forEntity:self];
}

- (TeamComponent *)team {
    return (TeamComponent *) [_entityManager getComponentOfClass:[TeamComponent class] forEntity:self];
}

- (GridComponent *)grid {
    return (GridComponent *) [_entityManager getComponentOfClass:[GridComponent class] forEntity:self];
}

- (MeleeComponent *)melee {
    return (MeleeComponent *) [_entityManager getComponentOfClass:[MeleeComponent class] forEntity:self];
}

- (TTLComponent *)ttl {
    return (TTLComponent *) [_entityManager getComponentOfClass:[TTLComponent class] forEntity:self];
}

- (RadarComponent *)radar {
    return (RadarComponent *) [_entityManager getComponentOfClass:[RadarComponent class] forEntity:self];
}

- (TargetComponent *)target {
    return (TargetComponent *) [_entityManager getComponentOfClass:[TargetComponent class] forEntity:self];
}

- (WeaponComponent *)weapon {
    return (WeaponComponent *) [_entityManager getComponentOfClass:[WeaponComponent class] forEntity:self];
}

- (PoisonComponent *)poison {
    return (PoisonComponent *) [_entityManager getComponentOfClass:[PoisonComponent class] forEntity:self];
}

- (CharacterComponent *)character {
    return (CharacterComponent *) [_entityManager getComponentOfClass:[CharacterComponent class] forEntity:self];
}

- (MoneyComponent *)money {
    return (MoneyComponent *) [_entityManager getComponentOfClass:[MoneyComponent class] forEntity:self];
}

@end
