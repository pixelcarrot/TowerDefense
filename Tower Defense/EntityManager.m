//
//  EntityManager.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/30/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "EntityManager.h"

@implementation EntityManager {
    NSMutableArray *_entities;
    NSMutableDictionary *_componentsByClass;
    uint32_t _lowestUnassignedEid;
}

- (id)init {
    if ((self = [super init])) {
        _entities = [[NSMutableArray alloc] init];
        _componentsByClass = [[NSMutableDictionary alloc] init];
        _lowestUnassignedEid = 1;
    }
    return self;
}

- (uint32_t)generateNewEid {
    if (_lowestUnassignedEid < UINT32_MAX) {
        return _lowestUnassignedEid++;
    } else {
        for (uint32_t i = 1; i < UINT32_MAX; ++i) {
            if (![_entities containsObject:@(i)]) {
                return i;
            }
        }
        NSLog(@"ERROR: No available EIDs!");
        return 0;
    }
}

- (Entity *)createEntity {
    uint32_t eid = [self generateNewEid];
    [_entities addObject:@(eid)];
    return [[Entity alloc] initWithEid:eid entityManager:self];
}

- (void)addComponent:(Component *)component toEntity:(Entity *)entity {
    NSMutableDictionary *components = _componentsByClass[NSStringFromClass([component class])];
    if (!components) {
        components = [NSMutableDictionary dictionary];
        _componentsByClass[NSStringFromClass([component class])] = components;
    }
    components[@(entity.eid)] = component;
}

- (void)removeComponent:(Component *)component fromEntity:(Entity *)entity {
    NSMutableDictionary *components = _componentsByClass[NSStringFromClass([component class])];
    if (components) {
        if (components[@(entity.eid)]) {
            [components removeObjectForKey:@(entity.eid)];
        }
    }
}

- (Component *)getComponentOfClass:(Class)class forEntity:(Entity *)entity {
    return _componentsByClass[NSStringFromClass(class)][@(entity.eid)];
}

- (void)removeEntity:(Entity *)entity {
    for (NSMutableDictionary *components in _componentsByClass.allValues) {
        if (components[@(entity.eid)]) {
            [components removeObjectForKey:@(entity.eid)];
        }
    }
    [_entities removeObject:@(entity.eid)];
}

- (NSArray *)getAllEntitiesPosessingComponentOfClass:(Class)class {
    NSMutableDictionary *components = _componentsByClass[NSStringFromClass(class)];
    if (components) {
        NSMutableArray *retval = [NSMutableArray arrayWithCapacity:components.allKeys.count];
        for (NSNumber *eid in components.allKeys) {
            [retval addObject:[[Entity alloc] initWithEid:eid.integerValue entityManager:self]];
        }
        return retval;
    } else {
        return [NSArray array];
    }
}

- (Entity *)getEntityByEid:(uint32_t)eid {
    return [[Entity alloc] initWithEid:eid entityManager:self];
}

@end
