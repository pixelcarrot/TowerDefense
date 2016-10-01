//
//  RadarSystem.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/4/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "cocos2d.h"
#import "EntityManager.h"
#import "RadarSystem.h"

@implementation RadarSystem

- (void)update:(float)dt {

    NSArray *entities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[RadarComponent class]];
    for (Entity *entity in entities) {

        RadarComponent *radar = entity.radar;
        GridComponent *grid = entity.grid;
        TeamComponent *team = entity.team;
        TargetComponent *target = entity.target;

        if (!radar || !grid || !team || !target) continue;

        if (target.eid >= 0) continue;

        if (radar.delay > 0) {
            radar.elapsed += dt;

            if (radar.elapsed < radar.delay) {
                continue;
            }

            radar.elapsed = 0;
        }

        NSMutableArray *enemies = [NSMutableArray array];

        NSArray *characters = [self.entityManager getAllEntitiesPosessingComponentOfClass:[CharacterComponent class]];
        for (Entity *character in characters) {
            if (character.team.team != team.team && character.grid.row == grid.row) {
                [enemies addObject:character];
            }
        }

        //NSArray * enemies = [entity getAllEntitiesOnTeam:OPPOSITE_TEAM(team.team)
        //posessingComponentOfClass:[HealthComponent class]];

        switch (grid.dir) {
            case NE: {

                int i = 0;
                int closest = -1;

                while (i < enemies.count) {
                    Entity *enemy = [enemies objectAtIndex:i];
                    i++;

                    if (enemy.health.alive == NO) {
                        continue;
                    }

                    if (entity.grid.row != enemy.grid.row) {
                        continue;
                    }

                    if (entity.grid.col > enemy.grid.col) {
                        continue;
                    }

                    if (ABS(entity.grid.col - enemy.grid.col) > radar.range) {
                        continue;
                    }

                    target.eid = enemy.eid;
                    closest = enemy.grid.col;
                    break;
                }

                while (i < enemies.count) {
                    Entity *enemy = [enemies objectAtIndex:i];
                    i++;

                    if (enemy.health.alive == NO) {
                        continue;
                    }

                    if (entity.grid.row != enemy.grid.row) {
                        continue;
                    }

                    if (entity.grid.col > enemy.grid.col) {
                        continue;
                    }

                    if (ABS(entity.grid.col - enemy.grid.col) > radar.range) {
                        continue;
                    }

                    if (closest < enemy.grid.col) {
                        continue;
                    }

                    target.eid = enemy.eid;
                    closest = enemy.grid.col;
                }
            }
                break;

            case SW: {

                int i = 0;
                int closest = -1;

                while (i < enemies.count) {
                    Entity *enemy = [enemies objectAtIndex:i];
                    i++;

                    if (enemy.health.alive == NO) {
                        continue;
                    }

                    if (entity.grid.row != enemy.grid.row) {
                        continue;
                    }

                    if (entity.grid.col < enemy.grid.col) {
                        continue;
                    }

                    if (ABS(entity.grid.col - enemy.grid.col) > radar.range) {
                        continue;
                    }

                    target.eid = enemy.eid;
                    closest = enemy.grid.col;
                    break;
                }

                while (i < enemies.count) {
                    Entity *enemy = [enemies objectAtIndex:i];
                    i++;

                    if (enemy.health.alive == NO) {
                        continue;
                    }

                    if (entity.grid.row != enemy.grid.row) {
                        continue;
                    }

                    if (entity.grid.col < enemy.grid.col) {
                        continue;
                    }

                    if (ABS(entity.grid.col - enemy.grid.col) > radar.range) {
                        continue;
                    }

                    if (closest > enemy.grid.col) {
                        continue;
                    }

                    target.eid = enemy.eid;
                    closest = enemy.grid.col;
                }
            }
                break;

            default:
                break;
        }
    }
}

@end
