//
//  IntroLayer.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/2/14.
//  Copyright Nguyen Hoang Anh Nguyen 2014. All rights reserved.
//

#import "IntroLayer.h"
#import "MainLayer.h"

#import "SimpleAudioEngine.h"

#pragma mark - IntroLayer

@implementation IntroLayer

+ (CCScene *)scene {
    CCScene *scene = [CCScene node];
    IntroLayer *layer = [IntroLayer node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    if ((self = [super init])) {

        CGSize size = [[CCDirector sharedDirector] winSize];

        CCSprite *background;

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            background = [CCSprite spriteWithFile:@"Default.png"];
            background.rotation = 90;
        } else {
            background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
        }
        background.position = ccp(size.width / 2, size.height / 2);

        [self addChild:background];

        [self setup];
    }

    return self;
}

- (void)setup {
    id pvrTexture;

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {

        // load spritesheet Heroes và Monsters
        pvrTexture = [[CCTextureCache sharedTextureCache] addImage:@"heroes.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"heroes.plist" texture:pvrTexture];
        pvrTexture = [[CCTextureCache sharedTextureCache] addImage:@"monsters.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"monsters.plist" texture:pvrTexture];

        // load spritesheet hiệu ứng Hit
        pvrTexture = [[CCTextureCache sharedTextureCache] addImage:@"hit.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"hit.plist" texture:pvrTexture];

        // load spritesheet giao diện màn hình
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"user-interface.plist"];

        // load spritesheet hiệu ứng skill
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"effect.plist"];
    }
    else {

        // load spritesheet Heroes và Monsters
        pvrTexture = [[CCTextureCache sharedTextureCache] addImage:@"heroes1-hd.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"heroes1-hd.plist" texture:pvrTexture];
        pvrTexture = [[CCTextureCache sharedTextureCache] addImage:@"heroes2-hd.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"heroes2-hd.plist" texture:pvrTexture];
        pvrTexture = [[CCTextureCache sharedTextureCache] addImage:@"monsters1-hd.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"monsters1-hd.plist" texture:pvrTexture];
        pvrTexture = [[CCTextureCache sharedTextureCache] addImage:@"monsters2-hd.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"monsters2-hd.plist" texture:pvrTexture];
        pvrTexture = [[CCTextureCache sharedTextureCache] addImage:@"monsters3-hd.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"monsters3-hd.plist" texture:pvrTexture];

        // load spritesheet hiệu ứng Hit
        pvrTexture = [[CCTextureCache sharedTextureCache] addImage:@"hit-hd.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"hit-hd.plist" texture:pvrTexture];

        // load spritesheet giao diện màn hình
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"user-interface-hd.plist"];

        // load spritesheet hiệu ứng skill
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"effect-hd.plist"];
    }

    [self initHeroAnimationCache:@"archer"];
    [self initHeroAnimationCache:@"paladin"];
    [self initHeroAnimationCache:@"knight"];
    [self initHeroAnimationCache:@"cannoneer"];
    [self initHeroAnimationCache:@"assassin"];
    [self initHeroAnimationCache:@"ninja"];
    [self initHeroAnimationCache:@"alchemist"];
    [self initHeroAnimationCache:@"scout"];
    [self initHeroAnimationCache:@"sniper"];
    [self initHeroAnimationCache:@"soldier"];
    [self initHeroAnimationCache:@"sorcerer"];
    [self initHeroAnimationCache:@"warrior"];

    [self initMonsterAnimationCache:@"armorSkeleton"];
    [self initMonsterAnimationCache:@"bat"];
    [self initMonsterAnimationCache:@"beezMan"];
    [self initMonsterAnimationCache:@"behemoth"];
    [self initMonsterAnimationCache:@"chimera"];
    [self initMonsterAnimationCache:@"cockatrice"];
    [self initMonsterAnimationCache:@"devilMan"];
    [self initMonsterAnimationCache:@"druid"];
    [self initMonsterAnimationCache:@"gargoyle"];
    [self initMonsterAnimationCache:@"gigantes"];
    [self initMonsterAnimationCache:@"goblin"];
    [self initMonsterAnimationCache:@"gremlin"];
    [self initMonsterAnimationCache:@"harpy"];
    [self initMonsterAnimationCache:@"hurricano"];
    [self initMonsterAnimationCache:@"kentauros"];
    [self initMonsterAnimationCache:@"lilith"];
    [self initMonsterAnimationCache:@"manticore"];
    [self initMonsterAnimationCache:@"scolpion"];
    [self initMonsterAnimationCache:@"skeleton"];
    [self initMonsterAnimationCache:@"snowMan"];
    [self initMonsterAnimationCache:@"tentacles"];
    [self initMonsterAnimationCache:@"warLion"];
    [self initMonsterAnimationCache:@"warWolf"];

    [self initHitAnimationCache];
    [self initSkillAnimationCache];

    [self preloadSound];
}

- (void)initSkillAnimationCache {
    NSMutableArray *electricBall = [NSMutableArray array];
    for (int i = 0; i <= 3; i++) {
        [electricBall addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"electric_ball_%i.png", i]]];
    }
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:electricBall delay:0.1f] name:@"electricBall"];

    NSMutableArray *darkness = [NSMutableArray array];
    for (int i = 0; i <= 12; i++) {
        [darkness addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"effect_%i.png", i]]];
    }
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:darkness delay:0.1f] name:@"darkness"];

    NSMutableArray *poisonBall = [NSMutableArray array];
    for (int i = 0; i <= 2; i++) {
        [poisonBall addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"poison_ball_%i.png", i]]];
    }
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:poisonBall delay:0.1f] name:@"poisonBall"];
}

- (void)initHitAnimationCache {
    NSMutableArray *hitArrow = [NSMutableArray array];
    NSMutableArray *hitBlade = [NSMutableArray array];
    NSMutableArray *hitHammer = [NSMutableArray array];
    NSMutableArray *hitKatana = [NSMutableArray array];
    NSMutableArray *hitSword = [NSMutableArray array];
    NSMutableArray *hitBullet = [NSMutableArray array];
    NSMutableArray *hitElectric = [NSMutableArray array];
    NSMutableArray *hitCanon = [NSMutableArray array];
    NSMutableArray *hitPoison = [NSMutableArray array];

    for (int i = 1; i <= 4; i++) {
        [hitArrow addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"hit_arrow_%i.png", i]]];
        [hitBlade addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"hit_blade_%i.png", i]]];
        [hitHammer addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"hit_hammer_%i.png", i]]];
        [hitKatana addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"hit_katana_%i.png", i]]];
        [hitSword addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"hit_sword_%i.png", i]]];
    }

    for (int i = 1; i <= 7; i++) {
        [hitBullet addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"hit_bullet_%i.png", i]]];
        [hitElectric addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"hit_electric_%i.png", i]]];
    }

    for (int i = 1; i <= 9; i++) {
        [hitCanon addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"hit_canon_%i.png", i]]];
    }

    for (int i = 0; i <= 5; i++) {
        [hitPoison addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"poison_hit_%i.png", i]]];
    }

    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:hitArrow delay:0.1f] name:@"hitArrow"];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:hitBlade delay:0.1f] name:@"hitBlade"];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:hitHammer delay:0.1f] name:@"hitHammer"];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:hitKatana delay:0.1f] name:@"hitKatana"];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:hitSword delay:0.1f] name:@"hitSword"];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:hitBullet delay:0.1f] name:@"hitBullet"];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:hitElectric delay:0.1f] name:@"hitElectric"];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:hitCanon delay:0.1f] name:@"hitCanon"];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:hitPoison delay:0.1f] name:@"hitPoison"];
}

- (void)initHeroAnimationCache:(NSString *)name {
    NSMutableArray *idlframes1 = [NSMutableArray array];
    NSMutableArray *idlframes2 = [NSMutableArray array];
    NSMutableArray *movframes1 = [NSMutableArray array];
    NSMutableArray *movframes2 = [NSMutableArray array];
    NSMutableArray *atkframes1 = [NSMutableArray array];
    NSMutableArray *atkframes2 = [NSMutableArray array];
    NSMutableArray *dieframes1 = [NSMutableArray array];
    NSMutableArray *dieframes2 = [NSMutableArray array];
    NSMutableArray *skl0frames1 = [NSMutableArray array];
    NSMutableArray *skl0frames2 = [NSMutableArray array];

    for (int i = 9; i <= 16; i++) {
        [idlframes1 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_blue_idl_%.2i.png", name, i]]];
        [idlframes2 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_blue_idl_%.2i.png", name, i + 16]]];
        [movframes1 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_blue_mov_%.2i.png", name, i]]];
        [movframes2 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_blue_mov_%.2i.png", name, i + 16]]];
        [atkframes1 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_blue_att_%.2i.png", name, i]]];
        [atkframes2 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_blue_att_%.2i.png", name, i + 16]]];
        [dieframes1 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_blue_die_%.2i.png", name, i]]];
        [dieframes2 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_blue_die_%.2i.png", name, i + 16]]];

        if ([name isEqual:@"alchemist"] || [name isEqual:@"paladin"] || [name isEqual:@"sniper"]) {
            [skl0frames1 addObject:
                    [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"unit_%@_blue_skl0_%.2i.png", name, i]]];
            [skl0frames2 addObject:
                    [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"unit_%@_blue_skl0_%.2i.png", name, i + 16]]];
        }
    }

    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:idlframes1 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_idle1", name]];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:idlframes2 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_idle2", name]];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:movframes1 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_move1", name]];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:movframes2 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_move2", name]];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:atkframes1 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_attack1", name]];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:atkframes2 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_attack2", name]];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:dieframes1 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_die1", name]];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:dieframes2 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_die2", name]];

    if ([name isEqual:@"alchemist"] || [name isEqual:@"paladin"] || [name isEqual:@"sniper"]) {
        [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:skl0frames1 delay:0.1f]
                                                         name:[NSString stringWithFormat:@"%@_skl01", name]];
        [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:skl0frames2 delay:0.1f]
                                                         name:[NSString stringWithFormat:@"%@_skl02", name]];
    }
}

- (void)initMonsterAnimationCache:(NSString *)name {
    NSMutableArray *idlframes1 = [NSMutableArray array];
    NSMutableArray *idlframes2 = [NSMutableArray array];
    NSMutableArray *movframes1 = [NSMutableArray array];
    NSMutableArray *movframes2 = [NSMutableArray array];
    NSMutableArray *atkframes1 = [NSMutableArray array];
    NSMutableArray *atkframes2 = [NSMutableArray array];
    NSMutableArray *dieframes1 = [NSMutableArray array];
    NSMutableArray *dieframes2 = [NSMutableArray array];

    for (int i = 9; i <= 16; i++) {
        [idlframes1 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", name, i]]];
        [idlframes2 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_idl_%.2i.png", name, i + 16]]];
        [movframes1 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_mov_%.2i.png", name, i]]];
        [movframes2 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_mov_%.2i.png", name, i + 16]]];
        [atkframes1 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_att_%.2i.png", name, i]]];
        [atkframes2 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_att_%.2i.png", name, i + 16]]];
        [dieframes1 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_die_%.2i.png", name, i]]];
        [dieframes2 addObject:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"unit_%@_die_%.2i.png", name, i + 16]]];
    }

    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:idlframes1 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_idle1", name]];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:idlframes2 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_idle2", name]];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:movframes1 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_move1", name]];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:movframes2 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_move2", name]];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:atkframes1 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_attack1", name]];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:atkframes2 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_attack2", name]];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:dieframes1 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_die1", name]];
    [[CCAnimationCache sharedAnimationCache] addAnimation:[CCAnimation animationWithSpriteFrames:dieframes2 delay:0.1f]
                                                     name:[NSString stringWithFormat:@"%@_die2", name]];
}

- (void)preloadSound {
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_alchemist.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_archer.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_armorSkeleton.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_assassin.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_bat.wav"];

    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_beezMen.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_behemoth.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_cannoneer.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_chimera.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_cockatrice.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_devilMan.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_druid.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_gargoyle.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_gigantes.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_goblin.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_gremlin.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_harpy.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_hurricano.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_kentauros.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_knight.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_lilith.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_manticore.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_ninja.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_paladin.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_scolpion.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_scout.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_skeleton.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_sniper.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_snowMan.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_soldier.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_sorcerer.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_tentacles.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_warLion.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_warrior.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"die_warWolf.wav"];


    [[SimpleAudioEngine sharedEngine] preloadEffect:@"atk_blade.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"atk_bow.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"atk_canon.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"atk_electric.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"atk_hammer.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"atk_katana.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"atk_poison.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"atk_rifle.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"atk_sword.wav"];

    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hit_arrow.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hit_blade.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hit_bullet.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hit_electric.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hit_fire.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hit_hammer.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hit_ice.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hit_katana.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hit_sword.wav"];
}

- (void)onEnter {
    [super onEnter];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene]]];
}
@end
