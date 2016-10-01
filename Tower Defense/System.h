//
//  System.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/30/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

@class EntityManager;
@class EntityFactory;

@interface System : NSObject

@property(strong) EntityManager *entityManager;
@property(strong) EntityFactory *entityFactory;

- (id)initWithEntityManager:(EntityManager *)entityManager entityFactory:(EntityFactory *)entityFactory;

- (void)update:(float)dt;

@end