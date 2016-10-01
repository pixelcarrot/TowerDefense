//
//  GameLayer.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 3/5/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "GameLayer.h"
#import "MainLayer.h"
#import "AboutLayer.h"
#import "MapLayer.h"
#import "SimpleAudioEngine.h"
#import "EntityManager.h"
#import "RenderComponent.h"
#import "HealthComponent.h"
#import "EntityFactory.h"
#import "GridSystem.h"
#import "MoveSystem.h"
#import "RadarSystem.h"
#import "HealthSystem.h"
#import "CharacterSystem.h"
#import "MeleeSystem.h"
#import "PoisonSystem.h"
#import "TTLSystem.h"

#import "UIShield.h"
#import "UISpawn.h"

#import "SimpleAudioEngine.h"

@implementation GameLayer {
    BOOL _gameOver;
    EntityManager *_entityManager;
    EntityFactory *_entityFactory;
    GridSystem *_gridSystem;
    CharacterSystem *_characterSystem;
    MoveSystem *_moveSystem;
    RadarSystem *_radarSystem;
    HealthSystem *_healthSystem;
    MeleeSystem *_meleeSystem;
    //PoisonSystem * _poisonSystem;
    TTLSystem *_ttlSystem;
    CCLayer *_layer;

    float _x0, _y0, _w, _h;
    float _xa, _ya, _xb, _yb, _xy, _xp, _yp;
    int _numrows, _numcols;
    float _outWidth, _outHeight;

    CCArray *_store;
    CCArray *_unlocked;
    CCMenu *_menuShield;
    CCSprite *_menuShieldBG;
    BOOL _isEquiped;
    CCLayer *_darkLayer;
    int _checkNoEquiped;
    CCArray *_posShields;
    CCArray *_cooldowns;

    CGPoint _oldPoint, _newPoint;

    CCSprite *_dragItem;
    CCSprite *_itemTouched;
    BOOL _isItemTouched;

    // Hiển thị túi kẹo
    CCSprite *_bag;

    // Hiển thị số lượng kẹo
    CCLabelTTF *_candyLabel;
    int _candyCount;

    // Hiển thị thanh máu của thành
    CCProgressTimer *_healthBar;
    CCLabelTTF *_castleLabel;

    //
    int _firstWave;
    int _secondWave;
    int _finalWave;
    int _lvlSpawn;

    int _numMonsters, _castleAttacked;
    int _castleHealth;

    CCArray *_monsters;

    // màn đang chơi
    int _mapNumber;
}

// khởi tạo màn chơi theo map
+ (CCScene *)sceneWithMap:(int)number {
    CCScene *scene = [CCScene node];
    GameLayer *layer = [[GameLayer alloc] initWithMap:number];
    [scene addChild:layer];
    return scene;
}

// tính trước vị trí đặt shield nhân vật bên trái màn hình
- (void)initShieldPosition {
    _posShields = [[CCArray alloc] init];
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"shield_archer1.png"];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    float width = frame.rect.size.width;
    float height = frame.rect.size.height;
    int num = 7;
    float t = (winSize.height - height * num) / (num + 1);
    float y = winSize.height - t - height / 2;
    int offsetX = 5;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        offsetX = 10;
    }
    for (int i = 0; i < num; ++i) {
        [_posShields addObject:[NSValue valueWithCGPoint:ccp(width / 2 + offsetX, y)]];
        y = y - height - t;
    }
}

// chọn lựa nhân vật để bắt đầu chơi game
- (void)pickShield:(id)sender {
    if (_store.count == 7)
        return;

    CCMenuItemSprite *item1 = (CCMenuItemSprite *) [_menuShield getChildByTag:[sender tag]];
    [item1 setColor:ccc3(169, 169, 169)];
    item1.isEnabled = NO;

    NSString *image = [NSString stringWithFormat:@"shield_%@1.png", [_unlocked objectAtIndex:[sender tag]]];
    UIShield *item = [UIShield spriteWithSpriteFrameName:image];
    item.position = item1.position;
    item.tag = [sender tag];

    [_store addObject:item];
    [self addChild:item z:2];

    CCArray *equipments = _posShields;

    int num = _store.count;
    int j = (int) (equipments.count / 2) - (int) (num / 2);
    int i = 0;
    while (i < num - 1) {
        UIShield *sprite = [_store objectAtIndex:i];
        NSValue *v = [_posShields objectAtIndex:j];
        sprite.position = [v CGPointValue];
        ++i;
        ++j;
    }

    NSValue *v = [_posShields objectAtIndex:j];
    id move = [CCMoveTo actionWithDuration:0.5f position:[v CGPointValue]];
    id callFuncN = [CCCallFuncN actionWithTarget:self selector:@selector(equiped:)];
    id sequence = [CCSequence actionOne:move two:callFuncN];
    [sequence setTag:9];
    [item runAction:sequence];

    CCMenuItemSprite *mis = (CCMenuItemSprite *) [_menuShield getChildByTag:100];
    mis.isEnabled = NO;

    _checkNoEquiped++;
}

// hình shield nhân vật di chuyển qua bên trái
- (void)equiped:(id)node {
    _checkNoEquiped--;

    UIShield *item = node;

    //if ([item tag] < 7) {
    item.flipX = YES;
    //}

    CCArray *equipments = _posShields;

    int num = _store.count;
    int j = (int) (equipments.count / 2) - (int) (num / 2);
    int i = 0;

    while (i < num) {
        UIShield *sprite = [_store objectAtIndex:i];
        NSValue *v = [_posShields objectAtIndex:j];
        sprite.position = [v CGPointValue];
        ++i;
        ++j;
    }

    if (_store.count != 0) {
        CCMenuItemSprite *btnPlay = (CCMenuItemSprite *) [_menuShield getChildByTag:100];
        CCSprite *sprite = (CCSprite *) btnPlay.normalImage;
        [sprite setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"btn_wax_light.png"]];

        if (_checkNoEquiped == 0) {
            CCMenuItemSprite *mis = (CCMenuItemSprite *) [_menuShield getChildByTag:100];
            mis.isEnabled = YES;
        }
    }
}

// xoá shield nhân vật bên trái
- (void)removeShieldEquiped:(CGPoint)touch {
    for (UIShield *item in _store) {
        if ([item getActionByTag:9] == nil && CGRectContainsPoint(item.boundingBox, touch)) {

            int tag = item.tag;

            [_store removeObject:item];
            [item removeFromParentAndCleanup:YES];

            CCArray *equipments = _posShields;

            int num = _store.count;
            int j = (int) (equipments.count / 2) - (int) (num / 2);
            int i = 0;

            while (i < num) {
                CCMenuItemSprite *sprite = [_store objectAtIndex:i];
                NSValue *v = [_posShields objectAtIndex:j];
                sprite.position = [v CGPointValue];
                ++i;
                ++j;
            }

            CCMenuItemSprite *item1 = (CCMenuItemSprite *) [_menuShield getChildByTag:tag];
            [item1 setColor:ccc3(255, 255, 255)];
            item1.isEnabled = YES;

            break;
        }
    }

    if (_store.count == 0) {
        CCMenuItemSprite *btnPlay = (CCMenuItemSprite *) [_menuShield getChildByTag:100];
        CCSprite *sprite = (CCSprite *) btnPlay.normalImage;
        [sprite setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"button_wax.png"]];
    }
}

// khởi tạo danh sách nhân vật để chọn lựa
- (void)initShieldSelection {
    _store = [[CCArray alloc] init];

    _unlocked = [CCArray arrayWithNSArray:[NSArray arrayWithObjects:@"alchemist",
                                                                    @"archer",
                                                                    @"assassin",
                                                                    @"cannoneer",
                                                                    @"knight",
                                                                    @"ninja",
                                                                    @"paladin",
                                                                    @"sniper",
                                                                    @"scout",
                                                                    @"warrior",
                                                                    @"soldier",
                                                                    @"sorcerer",
                    nil]];

    int fontPlay, fontShield, offsetYPlay, offsetYFontShield;
    float scale;

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        fontPlay = 21;
        fontShield = 6;
        offsetYPlay = 8;
        offsetYFontShield = 8;
        scale = 1.3;
    } else {
        fontPlay = 34;
        fontShield = 12;
        offsetYPlay = 40;
        offsetYFontShield = 16;
        scale = 1.5;
    }

    _isEquiped = NO;
    _darkLayer.visible = YES;

    CGSize winSize = [[CCDirector sharedDirector] winSize];

    _menuShieldBG = [CCSprite spriteWithSpriteFrameName:@"equipment_bg.png"];
    _menuShieldBG.position = ccp(winSize.width / 2, winSize.height / 2);
    _menuShieldBG.scaleY = scale;
    [self addChild:_menuShieldBG z:2];

    CCSprite *temp = [CCSprite spriteWithSpriteFrameName:@"shield_archer1.png"];

    float w = temp.textureRect.size.width + temp.textureRect.size.width / 2;
    float h = temp.textureRect.size.height + temp.textureRect.size.height / 10;

    float x0 = winSize.width / 2 - w * 2 + w / 2;
    float y0 = winSize.height / 2 + h * 1.5 - h / 2;

    CCSprite *wax = [CCSprite spriteWithSpriteFrameName:@"button_wax.png"];

    CCMenuItemSprite *btnPlay = [CCMenuItemSprite itemWithNormalSprite:wax
                                                        selectedSprite:nil
                                                                target:self
                                                              selector:@selector(play:)];
    btnPlay.scale = 0.55f;
    btnPlay.position = ccp(winSize.width / 2,
            winSize.height / 2 -
                    (_menuShieldBG.contentSize.height * scale) / 2 + btnPlay.contentSize.height * btnPlay.scale + offsetYPlay);

    [btnPlay setTag:100];

    CCLabelTTF *lblPlay = [CCLabelTTF labelWithString:@"Play" fontName:@"Marker Felt" fontSize:fontPlay];
    lblPlay.position = ccp(btnPlay.contentSize.width / 2, btnPlay.contentSize.height / 2);
    [btnPlay addChild:lblPlay z:2];

    _menuShield = [CCMenu menuWithItems:btnPlay, nil];
    _menuShield.position = ccp(0, 0);
    [self addChild:_menuShield z:2];

    int count = 0;
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < 4; ++j) {

            if (count >= _unlocked.count) {
                CCSprite *normal = [CCSprite spriteWithSpriteFrameName:@"shield_locked.png"];
                CCMenuItemSprite *item = [CCMenuItemSprite itemWithNormalSprite:normal selectedSprite:nil];
                item.position = ccp(x0 + j * w, y0 - i * h + 15);
                [_menuShield addChild:item];
            }
            else {
                NSString *image = [NSString stringWithFormat:@"shield_%@1.png", [_unlocked objectAtIndex:count]];
                CCSprite *normal = [CCSprite spriteWithSpriteFrameName:image];
                CCSprite *banner = [CCSprite spriteWithSpriteFrameName:@"shield_banner.png"];
                banner.position = ccp(normal.contentSize.width / 2, normal.contentSize.height / 2);

                CCLabelTTF *name = [CCLabelTTF labelWithString:[_unlocked objectAtIndex:count] fontName:@"Marker Felt" fontSize:fontShield];
                name.position = ccp(banner.contentSize.width / 2, offsetYFontShield);
                [banner addChild:name];

                [normal addChild:banner];

                CCMenuItemSprite *item = [CCMenuItemSprite itemWithNormalSprite:normal
                                                                 selectedSprite:nil
                                                                         target:self
                                                                       selector:@selector(pickShield:)];
                item.position = ccp(x0 + j * w, y0 - i * h + 15);
                [item setTag:count];
                [_menuShield addChild:item];
            }

            count++;
        }
    }
}

// khởi tạo màn chơi
- (id)initWithMap:(int)mapNumber {
    if ((self = [super init])) {

        _mapNumber = mapNumber;

        // đọc dữ liệu từ file plist
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        NSArray *array = [dict objectForKey:@"Maps"];
        NSDictionary *map = [array objectAtIndex:_mapNumber - 1];

        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *background;

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            _w = 30;
            _h = 15;
            _x0 = [[map objectForKey:@"x0"] floatValue];
            _y0 = [[map objectForKey:@"y0"] floatValue];

            background = [CCSprite spriteWithFile:[map objectForKey:@"Image"]];
        }
        else {
            _w = 45;
            _h = 22.5;
            _x0 = [[map objectForKey:@"x0HD"] floatValue];
            _y0 = [[map objectForKey:@"y0HD"] floatValue];

            background = [CCSprite spriteWithFile:[map objectForKey:@"ImageHD"]];
        }

        _numrows = [[map objectForKey:@"Row"] floatValue];;
        _numcols = [[map objectForKey:@"Col"] floatValue];;
        _xa = _x0 - _w;
        _ya = _y0;
        _xb = _xa + _numrows * _w;
        _yb = _ya - _numrows * _h;

        background.anchorPoint = ccp(0, 0);
        _layer = [CCLayer node];
        [_layer addChild:background];
        [self addChild:_layer];

        _outWidth = background.textureRect.size.width - size.width;
        _outHeight = background.textureRect.size.height - size.height;

        [_layer.camera setCenterX:_outWidth / 2 centerY:_outHeight / 2 centerZ:-1];
        [_layer.camera setEyeX:_outWidth / 2 eyeY:_outHeight / 2 eyeZ:0];

        _entityManager = [[EntityManager alloc] init];
        _entityFactory = [[EntityFactory alloc] initWithEntityManager:_entityManager layer:_layer];
        _characterSystem = [[CharacterSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
        _moveSystem = [[MoveSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
        _radarSystem = [[RadarSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
        _meleeSystem = [[MeleeSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
        _healthSystem = [[HealthSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
        //_poisonSystem = [[PoisonSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
        _ttlSystem = [[TTLSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
        _gridSystem = [[GridSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory
                                                            row:_numrows col:_numcols w:_w h:_h xa:_xa ya:_ya xb:_xb yb:_yb];


        _darkLayer = [[CCLayerColor alloc] initWithColor:ccc4(0x00, 0x00, 0x00, 0x80) width:size.width height:size.height];
        [self addChild:_darkLayer z:2];

        _dragItem = [CCSprite node];
        _dragItem.visible = NO;
        _dragItem.anchorPoint = ccp(0.5, 0.3);
        [_dragItem setOpacity:128];
        [self addChild:_dragItem z:1];

        [self initShieldPosition];
        [self initShieldSelection];

        // enable sự kiện touch 
        self.touchEnabled = YES;

        // khơi tạo lượng quái vật trong game 
        NSString *monsters = [map objectForKey:@"Monsters"];

        NSArray *txtVillains = [monsters componentsSeparatedByString:@"/"];

        Global_Monster_Counter = _numMonsters = [((NSString *) [txtVillains objectAtIndex:0]) intValue];

        _monsters = [[CCArray alloc] initWithCapacity:txtVillains.count - 1];

        if (txtVillains.count > 1) {
            for (int i = 1; i < txtVillains.count; ++i) {

                CCArray *v = [CCArray arrayWithCapacity:2];

                NSArray *data = [((NSString *) [txtVillains objectAtIndex:i]) componentsSeparatedByString:@"-"];
                int n = [(NSString *) [data objectAtIndex:1] intValue];

                [v addObject:(NSString *) [data objectAtIndex:0]];
                [v addObject:[NSNumber numberWithInt:n]];

                [_monsters addObject:v];
            }
        }

        _castleAttacked = 0;
        _castleHealth = [[map objectForKey:@"Health"] integerValue];
        _candyCount = [[map objectForKey:@"Money"] integerValue];;

        _firstWave = _numMonsters * 0.15;
        _secondWave = _numMonsters * 0.2;
    }
    return self;
}

// bắt đầu chơi game
- (void)play:(id)sender {
    if (_store.count == 0)
        return;

    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"battle.mp3" loop:YES];

    CGSize size = [[CCDirector sharedDirector] winSize];

    CCArray *temp = [[CCArray alloc] init];

    _cooldowns = [[CCArray alloc] init];
    CCSprite *cooldown = [CCSprite spriteWithSpriteFrameName:@"shield_cooldown.png"];

    int fontShield = 8;
    int offsetYFontShield = 8;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        fontShield = 16;
        offsetYFontShield = 16;
    }

    int i = 0;
    for (UIShield *shield in _store) {
        [self reorderChild:shield z:1];

        // đọc dữ liệu thông tin nhân vật 
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        NSDictionary *shields = [dict objectForKey:@"Shields"];
        NSString *data = [shields objectForKey:[_unlocked objectAtIndex:shield.tag]];
        NSArray *array = [data componentsSeparatedByString:@"-"];

        shield.cost = [[array objectAtIndex:0] integerValue];
        shield.cooldown = [[array objectAtIndex:1] floatValue];

        CCSprite *banner = [CCSprite spriteWithSpriteFrameName:@"shield_banner.png"];
        banner.position = ccp(shield.contentSize.width / 2, shield.contentSize.height / 2);
        [shield addChild:banner];

        CCLabelTTF *name = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", shield.cost]
                                              fontName:@"Marker Felt"
                                              fontSize:fontShield];
        name.position = ccp(banner.contentSize.width / 2, offsetYFontShield);
        [banner addChild:name];

        [temp addObject:[_unlocked objectAtIndex:shield.tag]];
        [shield setTag:i];

        CCProgressTimer *black = [CCProgressTimer progressWithSprite:cooldown];

        black.position = ccp(shield.position.x, shield.position.y);

        black.type = kCCProgressTimerTypeBar;
        black.barChangeRate = ccp(0, 1);
        black.midpoint = ccp(0.0, 0.0f);

        black.percentage = 100;
        [self addChild:black z:1];

        [_cooldowns addObject:black];
        CCProgressFromTo *delay = [CCProgressFromTo actionWithDuration:shield.cooldown from:100 to:0];
        [delay setTag:1];
        [black runAction:delay];

        i++;
    }

    _unlocked = temp;

    _isEquiped = YES;
    _darkLayer.visible = NO;

    [self removeChild:_menuShield cleanup:YES];
    [self removeChild:_menuShieldBG cleanup:YES];

    // khởi tạo thanh máu của thành
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _castleLabel = [CCLabelTTF labelWithString:@"Castle" fontName:@"Marker Felt" fontSize:32];
        _castleLabel.position = ccp(size.width - _castleLabel.contentSize.width, size.height - 32);
    }
    else {
        _castleLabel = [CCLabelTTF labelWithString:@"Castle" fontName:@"Marker Felt" fontSize:16];
        _castleLabel.position = ccp(size.width - _castleLabel.contentSize.width, size.height - 16);
    }
    [self addChild:_castleLabel z:TOP];
    CCSprite *redbar = [CCSprite spriteWithSpriteFrameName:@"castle_healthbar_red.png"];
    redbar.position = ccp(_castleLabel.position.x - _castleLabel.contentSize.width * 2, _castleLabel.position.y);
    [self addChild:redbar z:TOP];
    _healthBar = [CCProgressTimer progressWithSprite:[CCSprite spriteWithSpriteFrameName:@"castle_healthbar_green.png"]];
    _healthBar.position = redbar.position;
    _healthBar.type = kCCProgressTimerTypeBar;
    _healthBar.barChangeRate = ccp(1, 0);
    _healthBar.midpoint = ccp(0.0, 0.0f);
    _healthBar.percentage = 100;
    [self addChild:_healthBar z:TOP];

    // khởi tạo thả quái
    id delaySpawn = [CCDelayTime actionWithDuration:10.f];
    id startSpawn = [CCCallFunc actionWithTarget:self selector:@selector(startSpawn)];
    id sequence = [CCSequence actionOne:delaySpawn two:startSpawn];
    [self runAction:sequence];

    // khởi tạo hiển thị túi kẹo
    CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"equipment_bg.png"];
    bg.scaleX = 0.5;
    bg.scaleY = 0.25;
    bg.position = ccp(130, 25);
    [self addChild:bg];
    _bag = [CCSprite spriteWithSpriteFrameName:@"candy.png"];
    _bag.position = ccp(110, 25);
    [self addChild:_bag];
    _candyLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", _candyCount] fontName:@"Marker Felt" fontSize:20];
    _candyLabel.position = ccp(160, 25);
    _candyLabel.color = ccBLACK;
    [self addChild:_candyLabel];

    // khởi tạo nút pause
    CCSprite *pause = [CCSprite spriteWithSpriteFrameName:@"button_pause.png"];
    pause.position = ccp(size.width - pause.textureRect.size.width, 25);
    [pause setTag:CMD_PAUSE];
    [self addChild:pause z:TOP - 1];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _bag.position = ccp(210, 50);
        _candyLabel.fontSize = 50;
        _candyLabel.position = ccp(330, 50);
        bg.position = ccp(270, 50);
        pause.position = ccp(size.width - pause.textureRect.size.width, 50);
    }

    // enable vòng lặp game
    [self scheduleUpdate];
}

- (void)attackCastle {
    _castleAttacked++;
    _healthBar.percentage = 100 - (_castleAttacked * 100 / _castleHealth);
}

// thả quái
- (void)spawn:(id)node {
    UISpawn *sprite = node;
    NSString *name = sprite.name;

    Entity *entity = nil;

    if ([name isEqual:@"armorSkeleton"]) {
        entity = [_entityFactory createArmorSkeletonWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"bat"]) {
        entity = [_entityFactory createBatWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"beezMan"]) {
        entity = [_entityFactory createBeezManWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"behemoth"]) {
        entity = [_entityFactory createBehemothWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"chimera"]) {
        entity = [_entityFactory createChimeraWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"cockatrice"]) {
        entity = [_entityFactory createCockatriceWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"devilMan"]) {
        entity = [_entityFactory createDevilManWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"druid"]) {
        entity = [_entityFactory createDruidWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"gargoyle"]) {
        entity = [_entityFactory createGargoyleWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"gigantes"]) {
        entity = [_entityFactory createGigantesWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"goblin"]) {
        entity = [_entityFactory createGoblinWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"gremlin"]) {
        entity = [_entityFactory createGremlinWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"harpy"]) {
        entity = [_entityFactory createHarpyWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"hurricano"]) {
        entity = [_entityFactory createHurricanoWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"lilith"]) {
        entity = [_entityFactory createLilithWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"manticore"]) {
        entity = [_entityFactory createManticoreWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"scolpion"]) {
        entity = [_entityFactory createScolpionWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"skeleton"]) {
        entity = [_entityFactory createSkeletonWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"snowMan"]) {
        entity = [_entityFactory createSnowManWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"tentacles"]) {
        entity = [_entityFactory createTentaclesWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"warLion"]) {
        entity = [_entityFactory createWarLionWithTeam:2 row:-1 col:-1];
    }
    else if ([name isEqual:@"warWolf"]) {
        entity = [_entityFactory createWarWolfWithTeam:2 row:-1 col:-1];
    }

    if (entity != nil) {
        RenderComponent *render = entity.render;
        render.node.position = ccp(sprite.position.x, sprite.position.y - _h);
    }

    [node removeFromParentAndCleanup:YES];
}

// thả quái 
- (void)putMonster:(NSString *)name toRow:(int)row toCol:(int)col {
    if (row >= 0 && row < _numrows && col >= 0 && col < _numcols) {

        UISpawn *sprite = [[UISpawn alloc] initWithName:name];
        id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"darkness"];
        id animate = [CCAnimate actionWithAnimation:animation];
        id spawn = [CCCallFuncN actionWithTarget:self selector:@selector(spawn:)];
        id sequence = [CCSequence actionOne:animate two:spawn];
        [sprite runAction:sequence];

        [_layer addChild:sprite z:TOP];

        sprite.position = [self pointByRow:row andCol:col];
        sprite.position = ccp(sprite.position.x, sprite.position.y + _h * 2);
    }
}

// bắt đầu thả quái 
- (void)startSpawn {
    [self schedule:@selector(firstSpawn:) interval:10];
    _lvlSpawn = 1;
}

// thả quái lần 1
- (void)firstSpawn:(ccTime)deltaTime {
    int total = (arc4random() % _numrows) / 2 + 1;

    if (_numMonsters < total) {
        total = _numMonsters;
    }

    _numMonsters -= total;
    _firstWave -= total;

    for (int i = 0; i < total; ++i) {
        CCArray *v = [_monsters objectAtIndex:0];
        [self putMonster:[v objectAtIndex:0] toRow:arc4random() % _numrows toCol:0];
    }

    if (_firstWave <= 0) {
        [self unschedule:@selector(firstSpawn:)];
        [self schedule:@selector(secondSpawn:) interval:8];
        _lvlSpawn = 2;
    }
    else if (_numMonsters == 0) {
        [self unschedule:@selector(firstSpawn:)];
    }
}

// thả quái lần 2
- (void)secondSpawn:(ccTime)deltaTime {
    int total = (arc4random() % _numrows) / 2 + 1;

    if (_numMonsters < total) {
        total = _numMonsters;
    }

    _numMonsters -= total;
    _secondWave -= total;

    int roll = arc4random() % _monsters.count;

    while (total > 0) {

        CCArray *v = [_monsters objectAtIndex:roll];

        if (arc4random() % 100 < [(NSNumber *) [v objectAtIndex:1] intValue]) {
            int rand = arc4random() % _numrows;
            [self putMonster:[v objectAtIndex:0] toRow:rand toCol:0];
            total--;
        }

        roll++;

        if (roll >= _monsters.count) {
            roll = 0;
        }
    }

    if (_firstWave <= 0) {
        [self unschedule:@selector(secondSpawn:)];
        [self schedule:@selector(finalSpawn:) interval:5];
        _lvlSpawn = 3;
    }
    else if (_numMonsters == 0) {
        [self unschedule:@selector(secondSpawn:)];
    }
}

// thả quái lần cuối 
- (void)finalSpawn:(ccTime)deltaTime {
    int total = arc4random() % _numrows;

    if (_numMonsters < total) {
        total = _numMonsters;
    }

    _numMonsters -= total;

    int roll = arc4random() % _monsters.count;

    while (total > 0) {

        CCArray *v = [_monsters objectAtIndex:roll];

        if (arc4random() % 100 < [(NSNumber *) [v objectAtIndex:1] intValue]) {
            int rand = arc4random() % _numrows;
            [self putMonster:[v objectAtIndex:0] toRow:rand toCol:0];
            total--;
        }

        roll++;

        if (roll >= _monsters.count) {
            roll = 0;
        }
    }

    if (_numMonsters == 0) {
        [self unschedule:@selector(finalSpawn:)];
    }
}

// ngưng thả quái
- (void)stopSpawning {
    switch (_lvlSpawn) {
        case 1:
            [self unschedule:@selector(firstSpawn:)];
            break;
        case 2:
            [self unschedule:@selector(secondSpawn:)];
            break;
        case 3:
            [self unschedule:@selector(finalSpawn:)];
            break;

        default:
            break;
    }
}

// vòng lặp game 
- (void)update:(ccTime)dt {
    if (_castleAttacked >= _castleHealth) {
        [self defeated];
        return;
    }

    if (Global_Monster_Counter <= 0) {
        [self victory];
        return;
    }

    [_ttlSystem update:dt];
    [_gridSystem update:dt];

    NSArray *entities = [_entityManager getAllEntitiesPosessingComponentOfClass:[GridComponent class]];
    for (Entity *entity in entities) {
        if (entity.team.team == 2 && entity.grid.isOut == YES) {
            [self attackCastle];
        }
    }

    [_radarSystem update:dt];
    [_moveSystem update:dt];
    [_meleeSystem update:dt];
    [_healthSystem update:dt];
    [_characterSystem update:dt];
    //[_poisonSystem update:dt];
}

// enable sự kiện touch
- (void)registerWithTouchDispatcher {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

// nhặt kẹo
- (void)touchCandy:(CGPoint)touchPoint {

    float x, y, z;
    [_layer.camera centerX:&x centerY:&y centerZ:&z];

    NSArray *entities = [_entityManager getAllEntitiesPosessingComponentOfClass:[MoneyComponent class]];
    for (Entity *entity in entities) {

        RenderComponent *render = entity.render;

        if (CGRectContainsPoint(render.node.boundingBox, ccp(touchPoint.x + x, touchPoint.y + y))) {

            CCSprite *candy = [CCSprite spriteWithSpriteFrameName:@"candy.png"];
            candy.position = ccp(render.node.position.x - x, render.node.position.y - y);

            id collect = [CCMoveTo actionWithDuration:0.5f position:_bag.position];
            id collected = [CCCallFuncN actionWithTarget:self selector:@selector(collectCandy:)];
            id sequence = [CCSequence actionOne:collect two:collected];
            [candy runAction:sequence];

            [self addChild:candy];

            [render.node removeFromParentAndCleanup:YES];
            [_entityManager removeEntity:entity];
        }
    }
}

// cục kẹo di chuyển về túi kẹo
- (void)collectCandy:(id)node {
    _candyCount++;
    [_candyLabel setString:[NSString stringWithFormat:@"%i", _candyCount]];
    [node removeFromParentAndCleanup:YES];
}

// sự kiện touch vào màn hình
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [self convertTouchToNodeSpace:touch];

    if (_isEquiped == NO) {
        [self removeShieldEquiped:touchPoint];
        return YES;
    }

    id cmdResume = [self getChildByTag:TEXT_RESUME];
    if (cmdResume != nil) {
        CCSprite *sprite = cmdResume;
        if (CGRectContainsPoint(sprite.boundingBox, touchPoint)) {
            [self resume];
            return YES;
        }
    }

    id cmdQuit = [self getChildByTag:TEXT_QUIT];
    if (cmdQuit != nil) {
        CCSprite *sprite = cmdQuit;
        if (CGRectContainsPoint(sprite.boundingBox, touchPoint)) {
            [self quit];
            return YES;
        }
    }

    id cmdWorldMap = [self getChildByTag:TEXT_WORLDMAP];
    if (cmdWorldMap != nil) {
        CCSprite *sprite = cmdWorldMap;
        if (CGRectContainsPoint(sprite.boundingBox, touchPoint)) {
            [self worldmap];
            return YES;
        }
    }

    id cmdNext = [self getChildByTag:TEXT_NEXT];
    if (cmdNext != nil) {
        CCSprite *sprite = cmdNext;
        if (CGRectContainsPoint(sprite.boundingBox, touchPoint)) {
            [self next];
            return YES;
        }
    }

    id cmdRestart = [self getChildByTag:TEXT_REPLAY];
    if (cmdRestart != nil) {
        CCSprite *sprite = cmdRestart;
        if (CGRectContainsPoint(sprite.boundingBox, touchPoint)) {
            [self restart];
            return YES;
        }
    }

    id cmdPause = [self getChildByTag:CMD_PAUSE];
    if (cmdResume == nil && cmdPause != nil) {
        CCSprite *sprite = cmdPause;
        if (CGRectContainsPoint(sprite.boundingBox, touchPoint)) {
            [self option];
            return YES;
        }
    }

    [self touchCandy:touchPoint];

    _oldPoint = touchPoint;

    //NSLog(@"Touch at: %@", NSStringFromCGPoint(touchPoint));

    int pos = [self touchShield:_oldPoint];

    if (pos != -1) {
        int row = -1, col = -1;
        [self getRow:&row andCol:&col fromPoint:_oldPoint];
        if (row >= 0 && row < _numrows && col >= 0 && col < _numcols) {
            if ([self putShield:[_unlocked objectAtIndex:pos] toRow:row toCol:col]) {

                [self buy:[_store objectAtIndex:pos]];

                UIShield *s = [_store objectAtIndex:pos];
                id black = [_cooldowns objectAtIndex:pos];
                id delay = [CCProgressFromTo actionWithDuration:s.cooldown from:100 to:0];
                [delay setTag:1];
                [black runAction:delay];
            }
        }
    }

    return YES;
}

// sự kiện touch vào màn hình nhưng chưa nhấc tay lên mà tiếp tục di chuyển
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [self convertTouchToNodeSpace:touch];

    if (_isEquiped == NO)
        return;

    _newPoint = touchPoint;

    [self draggingShield:_newPoint];

    if (_dragItem.visible == NO && _itemTouched == nil) {
        [self viewWithOlPoint:_oldPoint andNewPoint:_newPoint];
    }

    _oldPoint = _newPoint;
}

// sự kiện nhấc tay lên khỏi màn hình sau khi touch
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [self convertTouchToNodeSpace:touch];

    if (_isEquiped == NO)
        return;

    _oldPoint = touchPoint;

    int pos = [self draggedOrTouchShield:_oldPoint];
    if (pos != -1) {
        int row = -1, col = -1;
        [self getRow:&row andCol:&col fromPoint:_oldPoint];
        if (row >= 0 && row < _numrows && col >= 0 && col < _numcols) {
            if ([self putShield:[_unlocked objectAtIndex:pos] toRow:row toCol:col]) {

                [self buy:[_store objectAtIndex:pos]];

                UIShield *s = [_store objectAtIndex:pos];
                id black = [_cooldowns objectAtIndex:pos];
                id delay = [CCProgressFromTo actionWithDuration:s.cooldown from:100 to:0];
                [delay setTag:1];
                [black runAction:delay];
            }
        }
    }
}

// chọn một nhân vật để đặt lên ô
- (int)touchShield:(CGPoint)point {
    int i = -1;

    if (_isItemTouched && _itemTouched) {
        i = _itemTouched.tag;
        if (CGRectContainsPoint(_itemTouched.boundingBox, point)) {
            i = -1;
        }
        [_itemTouched setDisplayFrame:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                        [NSString stringWithFormat:@"shield_%@1.png", [_unlocked objectAtIndex:_itemTouched.tag]]]];
    }

    id tempTouched = [self checkItems:point];

    if (_itemTouched == tempTouched) {
        _isItemTouched = NO;
        [_itemTouched setDisplayFrame:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                        [NSString stringWithFormat:@"shield_%@1.png", [_unlocked objectAtIndex:_itemTouched.tag]]]];
        _itemTouched = nil;
        return -1;
    }

    _itemTouched = nil;
    _itemTouched = tempTouched;
    if (_itemTouched) {
        _isItemTouched = NO;
        [_itemTouched setDisplayFrame:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                        [NSString stringWithFormat:@"shield_%@2.png", [_unlocked objectAtIndex:_itemTouched.tag]]]];
        i = -1;
    }

    return i;
}

// di chuyển preview nhân vật sẽ đặt vào ô
- (void)draggingShield:(CGPoint)point {
    if (_dragItem.visible) {
        _dragItem.position = point;
    }

    if (_itemTouched && CGRectContainsPoint(_itemTouched.boundingBox, point) == NO) {
        NSString *name = [NSString stringWithFormat:@"unit_%@_blue_idl_09.png", [_unlocked objectAtIndex:_itemTouched.tag]];
        [_dragItem setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
        _dragItem.position = point;
        _dragItem.visible = YES;
        _dragItem.tag = _itemTouched.tag;

        [_itemTouched setDisplayFrame:
                [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                        [NSString stringWithFormat:@"shield_%@1.png", [_unlocked objectAtIndex:_itemTouched.tag]]]];
        _itemTouched = nil;
    }
}

// thả nhân vật xuống sau khi di chuyển hoặc là chọn một nhân vật mới
- (int)draggedOrTouchShield:(CGPoint)point {
    int i = -1;

    if (_dragItem.visible) {
        i = _dragItem.tag;
        _dragItem.visible = NO;
    }

    if (_itemTouched && CGRectContainsPoint(_itemTouched.boundingBox, point)) {
        _isItemTouched = YES;
    }

    return i;
}

// convert vị trí ô sang toạ độ
- (CGPoint)pointByRow:(int)row andCol:(int)col {
    return ccp(_x0 + _w * (col + row), _y0 + _h * (col - row));
}

// convert toạ độ sang vị trí ô
- (void)getRow:(int *)row andCol:(int *)col fromPoint:(CGPoint)p {
    float x, y, z;
    [_layer.camera centerX:&x centerY:&y centerZ:&z];

    float xp = p.x + x;
    float yp = p.y + y;

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

// di chuyển camera nếu màn chơi lớn hơn màn hình
- (void)viewWithOlPoint:(CGPoint)oldPoint andNewPoint:(CGPoint)newPoint {
    float x, y, z;
    [_layer.camera centerX:&x centerY:&y centerZ:&z];

    float offsetX = newPoint.x - oldPoint.x;
    float offsetY = newPoint.y - oldPoint.y;

    x -= offsetX;
    y -= offsetY;

    if (x < 0)
        x = 0;
    else if (x > _outWidth)
        x = _outWidth;
    if (y < 0)
        y = 0;
    else if (y > _outHeight)
        y = _outHeight;

    [_layer.camera setCenterX:x centerY:y centerZ:z];
    [_layer.camera setEyeX:x eyeY:y eyeZ:0];
}

// đặt nhân vật vào ô trên màn chơi
- (BOOL)putShield:(NSString *)name toRow:(int)row toCol:(int)col {
    if (col == 0) {
        return NO;
    }
    NSArray *entities = [_entityManager getAllEntitiesPosessingComponentOfClass:[CharacterComponent class]];
    for (Entity *entity in entities) {
        TeamComponent *team = entity.team;
        GridComponent *grid = entity.grid;

        if (team.team == 1) {
            if (grid.row == row && grid.col == col) {
                return NO;
            }
        }
    }

    Entity *hero = nil;

    if ([name isEqual:@"alchemist"]) {
        hero = [_entityFactory createAlchemistWithTeam:1 row:row col:col];
    }
    if ([name isEqual:@"archer"]) {
        hero = [_entityFactory createArcherWithTeam:1 row:row col:col];
    }
    if ([name isEqual:@"cannoneer"]) {
        hero = [_entityFactory createCannoneerWithTeam:1 row:row col:col];
    }
    if ([name isEqual:@"assassin"]) {
        hero = [_entityFactory createAssassinWithTeam:1 row:row col:col];
    }
    if ([name isEqual:@"knight"]) {
        hero = [_entityFactory createKnightWithTeam:1 row:row col:col];
    }
    if ([name isEqual:@"paladin"]) {
        hero = [_entityFactory createPaladinWithTeam:1 row:row col:col];
    }
    if ([name isEqual:@"ninja"]) {
        hero = [_entityFactory createNinjaWithTeam:1 row:row col:col];
    }
    if ([name isEqual:@"sniper"]) {
        hero = [_entityFactory createSniperWithTeam:1 row:row col:col];
    }
    if ([name isEqual:@"scout"]) {
        hero = [_entityFactory createScoutWithTeam:1 row:row col:col];
    }
    if ([name isEqual:@"warrior"]) {
        hero = [_entityFactory createWarriorWithTeam:1 row:row col:col];
    }
    if ([name isEqual:@"soldier"]) {
        hero = [_entityFactory createSoldierWithTeam:1 row:row col:col];
    }
    if ([name isEqual:@"sorcerer"]) {
        hero = [_entityFactory createSorcererWithTeam:1 row:row col:col];
    }

    if (!hero) {
        return NO;
    }

    RenderComponent *render = hero.render;
    render.node.position = [self pointByRow:row andCol:col];
    render.node.position = ccp(render.node.position.x, render.node.position.y + _h);

    return YES;
}

// kiểm tra có đủ kẹo để mua nhân vật
- (id)checkItems:(CGPoint)touchPoint {
    int i = 0;

    for (UIShield *sd in _store) {
        if (CGRectContainsPoint(sd.boundingBox, touchPoint)) {

            CCProgressTimer *black = [_cooldowns objectAtIndex:i];

            if (black.percentage != 0) {
                //[[SimpleAudioEngine sharedEngine] playEffect:@"beep1.wav"];
                return nil;
            }

            if (sd.cost > _candyCount) {
                //[[SimpleAudioEngine sharedEngine] playEffect:@"beep1.wav"];
                return nil;
            }

            return sd;
        }
        i++;
    }

    return nil;
}

// trừ số kẹo khi đã mua nhân vật
- (void)buy:(UIShield *)sd {
    _candyCount = _candyCount - sd.cost;
    [_candyLabel setString:[NSString stringWithFormat:@"%i", _candyCount]];
}

- (void)worldmap {
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [self unscheduleUpdate];

    [[CCDirector sharedDirector] replaceScene:
            [CCTransitionFade transitionWithDuration:0.5f scene:[MapLayer scene]]];
}

- (void)restart {
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [self unscheduleUpdate];

    [[CCDirector sharedDirector] replaceScene:
            [CCTransitionFade transitionWithDuration:0.5f scene:[GameLayer sceneWithMap:_mapNumber]]];
}

- (void)quit {
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [self unscheduleUpdate];

    [[CCDirector sharedDirector] replaceScene:
            [CCTransitionFade transitionWithDuration:0.5f scene:[MainLayer scene]]];
}

- (void)next {
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [self unscheduleUpdate];

    if (_mapNumber + 1 <= 12) {
        [[CCDirector sharedDirector] replaceScene:
                [CCTransitionFade transitionWithDuration:0.5f scene:[GameLayer sceneWithMap:_mapNumber + 1]]];
    }
    else {
        [[CCDirector sharedDirector] replaceScene:
                [CCTransitionFade transitionWithDuration:0.5f scene:[AboutLayer scene]]];
    }
}

- (void)resume {
    _darkLayer.visible = NO;
    [self removeChildByTag:TEXT_OPTIONS cleanup:YES];
    [self removeChildByTag:TEXT_RESUME cleanup:YES];
    [self removeChildByTag:TEXT_WORLDMAP cleanup:YES];
    [self removeChildByTag:TEXT_QUIT cleanup:YES];
    [self removeChildByTag:MENU_BACKGROUND cleanup:YES];
    [self resumeSchedulerAndActions];
    for (CCNode *child in [self children]) {
        [child resumeSchedulerAndActions];
    }
}

- (void)option {
    CCSprite *sprOptions = [CCSprite spriteWithSpriteFrameName:@"text_options.png"];
    CCSprite *sprResume = [CCSprite spriteWithSpriteFrameName:@"text_resume.png"];
    CCSprite *sprWorldmap = [CCSprite spriteWithSpriteFrameName:@"text_worldmap.png"];
    CCSprite *sprQuit = [CCSprite spriteWithSpriteFrameName:@"text_quit.png"];

    [sprOptions setTag:TEXT_OPTIONS];
    [sprResume setTag:TEXT_RESUME];
    [sprWorldmap setTag:TEXT_WORLDMAP];
    [sprQuit setTag:TEXT_QUIT];

    [self addChild:sprOptions z:TOP];
    [self addChild:sprResume z:TOP];
    [self addChild:sprWorldmap z:TOP];
    [self addChild:sprQuit z:TOP];

    [self initMenuWithTitle:sprOptions option1:sprQuit option2:sprWorldmap option3:sprResume];

    [self pauseSchedulerAndActions];
    for (CCNode *child in [self children]) {
        [child pauseSchedulerAndActions];
    }
}

- (void)victory {
    [self unscheduleUpdate];

    CCSprite *sprVictory = [CCSprite spriteWithSpriteFrameName:@"text_victory.png"];
    CCSprite *sprNext = [CCSprite spriteWithSpriteFrameName:@"text_next.png"];
    CCSprite *sprWorldmap = [CCSprite spriteWithSpriteFrameName:@"text_worldmap.png"];
    CCSprite *sprQuit = [CCSprite spriteWithSpriteFrameName:@"text_quit.png"];

    [sprNext setTag:TEXT_NEXT];
    [sprWorldmap setTag:TEXT_WORLDMAP];
    [sprQuit setTag:TEXT_QUIT];

    [self addChild:sprVictory z:TOP];
    [self addChild:sprNext z:TOP];
    [self addChild:sprWorldmap z:TOP];
    [self addChild:sprQuit z:TOP];

    [self initMenuWithTitle:sprVictory option1:sprQuit option2:sprWorldmap option3:sprNext];

    id pause = [self getChildByTag:CMD_PAUSE];
    [pause removeFromParentAndCleanup:YES];
}

- (void)defeated {
    [self unscheduleUpdate];

    CCSprite *sprDefeat = [CCSprite spriteWithSpriteFrameName:@"text_defeated.png"];
    CCSprite *sprQuit = [CCSprite spriteWithSpriteFrameName:@"text_quit.png"];
    CCSprite *sprWorldmap = [CCSprite spriteWithSpriteFrameName:@"text_worldmap.png"];
    CCSprite *sprRestart = [CCSprite spriteWithSpriteFrameName:@"text_restart.png"];

    [sprQuit setTag:TEXT_QUIT];
    [sprWorldmap setTag:TEXT_WORLDMAP];
    [sprRestart setTag:TEXT_REPLAY];

    [self addChild:sprDefeat z:TOP];
    [self addChild:sprQuit z:TOP];
    [self addChild:sprWorldmap z:TOP];
    [self addChild:sprRestart z:TOP];

    [self initMenuWithTitle:sprDefeat option1:sprQuit option2:sprWorldmap option3:sprRestart];

    id pause = [self getChildByTag:CMD_PAUSE];
    [pause removeFromParentAndCleanup:YES];
}

- (void)initMenuWithTitle:(CCSprite *)title option1:(CCSprite *)opt1 option2:(CCSprite *)opt2 option3:(CCSprite *)opt3 {

    _darkLayer.visible = YES;

    CGSize size = [[CCDirector sharedDirector] winSize];

    CCSprite *paper = [CCSprite spriteWithSpriteFrameName:@"equipment_bg.png"];
    paper.position = ccp(size.width / 2, size.height / 2);
    [paper setTag:MENU_BACKGROUND];
    [self addChild:paper z:TOP - 1];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        title.position = ccp(size.width / 2, size.height - 123);
        opt1.position = ccp(147, size.height - 206);
        opt2.position = ccp(size.width / 2, size.height - 206);
        opt3.position = ccp(332, size.height - 206);
    }
    else {
        title.position = ccp(size.width / 2, size.height - 313);
        opt1.position = ccp(337, size.height - 468);
        opt2.position = ccp(size.width / 2, size.height - 468);
        opt3.position = ccp(688, size.height - 468);
    }
}

@end
