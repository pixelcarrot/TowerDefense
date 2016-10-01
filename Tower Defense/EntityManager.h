//
//  EntityManager.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/30/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "Entity.h"
#import "Component.h"

@interface EntityManager : NSObject

- (uint32_t)generateNewEid;

- (Entity *)createEntity;

- (void)addComponent:(Component *)component toEntity:(Entity *)entity;

- (void)removeComponent:(Component *)component fromEntity:(Entity *)entity;

- (Component *)getComponentOfClass:(Class)class forEntity:(Entity *)entity;

- (void)removeEntity:(Entity *)entity;

- (NSArray *)getAllEntitiesPosessingComponentOfClass:(Class)class;

- (Entity *)getEntityByEid:(uint32_t)eid;

@end