//
//  System.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/30/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "System.h"

@implementation System

- (id)initWithEntityManager:(EntityManager *)entityManager entityFactory:(EntityFactory *)entityFactory {
    if ((self = [super init])) {
        self.entityManager = entityManager;
        self.entityFactory = entityFactory;
    }
    return self;
}

- (void)update:(float)dt {

}

@end