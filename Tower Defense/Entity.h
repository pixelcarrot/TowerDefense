//
//  Entity.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/30/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "RenderComponent.h"
#import "MoveComponent.h"
#import "HealthComponent.h"
#import "TeamComponent.h"
#import "GridComponent.h"
#import "MeleeComponent.h"
#import "RadarComponent.h"
#import "CharacterComponent.h"
#import "TargetComponent.h"
#import "WeaponComponent.h"
#import "PoisonComponent.h"
#import "MoneyComponent.h"
#import "TTLComponent.h"

@class EntityManager;

@interface Entity : NSObject

- (id)initWithEid:(uint32_t)eid entityManager:(EntityManager *)entityManager;

- (uint32_t)eid;

- (RenderComponent *)render;

- (MoveComponent *)move;

- (HealthComponent *)health;

- (TeamComponent *)team;

- (GridComponent *)grid;

- (MeleeComponent *)melee;

- (RadarComponent *)radar;

- (CharacterComponent *)character;

- (TargetComponent *)target;

- (WeaponComponent *)weapon;

- (PoisonComponent *)poison;

- (MoneyComponent *)money;

- (TTLComponent *)ttl;

@end
