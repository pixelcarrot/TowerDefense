//
//  EntityFactory.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/30/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

@class Entity;
@class EntityManager;

@interface EntityFactory : NSObject

- (id)initWithEntityManager:(EntityManager *)entityManager layer:(CCLayer *)layer;

// khởi tạo heroes
- (Entity *)createAlchemistWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createArcherWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createAssassinWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createCannoneerWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createKnightWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createNinjaWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createPaladinWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createScoutWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createSniperWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createWarriorWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createSoldierWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createSorcererWithTeam:(int)team row:(int)row col:(int)col;

// khởi tạo monsters
- (Entity *)createArmorSkeletonWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createBatWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createBeezManWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createBehemothWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createChimeraWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createCockatriceWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createDevilManWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createDruidWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createGargoyleWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createGigantesWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createGoblinWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createGremlinWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createHarpyWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createHurricanoWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createKentaurosWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createLilithWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createManticoreWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createScolpionWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createSkeletonWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createSnowManWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createTentaclesWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createWarLionWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createWarWolfWithTeam:(int)team row:(int)row col:(int)col;

- (Entity *)createCandyWithPosition:(CGPoint)pos;

- (Entity *)createPoisonBallWithTeam:(int)team targetEid:(int)eid damage:(int)damage row:(int)row col:(int)col;

- (Entity *)createElectricBallWithTeam:(int)team targetEid:(int)eid damage:(int)damage row:(int)row col:(int)col;

- (Entity *)createBulletWithTeam:(int)team targetEid:(int)eid damage:(int)damage row:(int)row col:(int)col;

- (Entity *)createArrowWithTeam:(int)team targetEid:(int)eid damage:(int)damage row:(int)row col:(int)col;

- (Entity *)createSlugWithTeam:(int)team targetEid:(int)eid damage:(int)damage row:(int)row col:(int)col;

- (Entity *)createDamage:(int)damage targetEid:(int)eid animation:(NSString *)animation;

@end
