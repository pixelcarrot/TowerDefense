//
//  GridSystem.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/1/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "cocos2d.h"
#import "EntityManager.h"
#import "GridSystem.h"

@implementation GridSystem {
    float _xa, _ya, _xb, _yb, _w, _h;
    int _numrows, _numcols;
}

- (id)initWithEntityManager:(EntityManager *)entityManager entityFactory:(EntityFactory *)entityFactory
                        row:(int)numrows col:(int)numcols w:(float)w h:(float)h xa:(float)xa ya:(float)ya xb:(float)xb yb:(float)yb; {
    if ((self = [super initWithEntityManager:entityManager entityFactory:entityFactory])) {
        _xa = xa;
        _ya = ya;
        _xb = xb;
        _yb = yb;
        _w = w;
        _h = h;
        _numrows = numrows;
        _numcols = numcols;
    }
    return self;
}

- (void)getRow:(int *)row andCol:(int *)col fromPoint:(CGPoint)p {
    float xp = p.x;
    float yp = p.y;

    float pm = fabsf(xp - _xa);
    float mr = pm * 0.5;
    float yr = yp - mr;

    float pn = fabsf(yp - _yb);
    float nc = pn * 2;
    float xc = xp + nc;

    if (_ya >= yr && yr >= _ya - 2 * _numrows * _h && _xb <= xc && xc <= _xb + 2 * _numcols * _w) {
        *row = (int) (_ya - yr) / (2 * _h);
        *col = (int) (xc - _xb) / (2 * _w);
    }
}

- (void)update:(float)dt {
    NSArray *entities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[GridComponent class]];
    for (Entity *entity in entities) {

        //MoveComponent * move = entity.move;
        RenderComponent *render = entity.render;
        GridComponent *grid = entity.grid;
        //TeamComponent * team = entity.team;
        //if (!move || !render || !team) continue;
        HealthComponent *health = entity.health;
        MoveComponent *move = entity.move;
        if (!health) continue;

        if (move) {
            switch (grid.dir) {
                case NE:
                    move.target = ccp(12, 6);
                    break;
                case SE:
                    move.target = ccp(12, -6);
                    break;
                case SW:
                    move.target = ccp(-12, -6);
                    break;
                case NW:
                    move.target = ccp(-12, 6);
                    break;
                default:
                    break;
            }
        }

        int row = -1, col = -1;
        [self getRow:&row andCol:&col fromPoint:ccp(render.node.position.x, render.node.position.y - _h / 2)];

        //if (row != -1 && col != -1) {
        entity.grid.row = row;
        entity.grid.col = col;
        //}

        if (row == -1 || col == -1) {
            grid.isOut = YES;
            [entity.render.node stopAllActions];
        }

        if (row != -1 && col != -1) {
            entity.render.node.zOrder = row + _numcols - col;
        }
    }
}

@end
