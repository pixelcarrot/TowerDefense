//
//  GridSystem.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/1/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "System.h"

@interface GridSystem : System

- (id)initWithEntityManager:(EntityManager *)entityManager entityFactory:(EntityFactory *)entityFactory
                        row:(int)numrows col:(int)numcols w:(float)w h:(float)h xa:(float)xa ya:(float)ya xb:(float)xb yb:(float)yb;

@end
