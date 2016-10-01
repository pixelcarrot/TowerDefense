//
//  AboutLayer.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 3/5/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "AboutLayer.h"
#import "MainLayer.h"

@implementation AboutLayer {
    float _x0, _y0, _w, _h;
    float _xa, _ya, _xb, _yb, _xy, _xp, _yp;
    int _numrows, _numcols;
    float _outWidth, _outHeight;
}

+ (CCScene *)scene {
    CCScene *scene = [CCScene node];
    AboutLayer *layer = [AboutLayer node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    if ((self = [super init])) {

        CGSize size = [[CCDirector sharedDirector] winSize];

        CCSprite *background;

        int fontSize;

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            _w = 30;
            _h = 15;
            _x0 = 77;
            _y0 = 135;
            background = [CCSprite spriteWithFile:@"map_01.png"];
            fontSize = 18;
        } else {
            _w = 45;
            _h = 22.5;
            _x0 = 269;
            _y0 = 347;
            background = [CCSprite spriteWithFile:@"map_01-hd.png"];
            fontSize = 24;
        }
        _numrows = 6;
        _numcols = 8;
        _xa = _x0 - _w;
        _ya = _y0;
        _xb = _xa + _numrows * _w;
        _yb = _ya - _numrows * _h;

        background.position = ccp(size.width / 2, size.height / 2);
        [self addChild:background];

        [self sorcerer];
        [self alchemist];
        [self archer];
        [self ninja];
        [self assassin];
        [self scout];
        [self cannoneer];
        [self sniper];
        [self warrior];
        [self paladin];
        [self knight];
        [self soldier];

        CCLayer *_darkLayer = [[CCLayerColor alloc] initWithColor:ccc4(0x00, 0x00, 0x00, 0x80) width:size.width height:size.height];
        [self addChild:_darkLayer];

        CCSprite *paper = [CCSprite spriteWithSpriteFrameName:@"equipment_bg.png"];
        paper.position = ccp(size.width / 2, size.height / 2);
        [self addChild:paper];

        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Academic Project" fontName:@"Marker Felt" fontSize:fontSize * 2];
        title.position = ccp(size.width / 2, size.height / 2 + fontSize * 2);
        title.color = ccBLACK;
        [self addChild:title];

        CCLabelTTF *nguyen = [CCLabelTTF labelWithString:@"Copyright (c) 2014 Nguyen Hoang Anh Nguyen.\nAll rights reserved." fontName:@"Marker Felt" fontSize:fontSize];
        nguyen.position = ccp(size.width / 2, size.height / 2 - fontSize / 2);
        nguyen.color = ccBLACK;
        [self addChild:nguyen];

        self.touchEnabled = YES;
    }

    return self;
}

- (void)registerWithTouchDispatcher {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene]]];
    return YES;
}

- (void)alchemist {
    CCSprite *sprite = [CCSprite node];
    id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"alchemist_skl01"];
    id animate = [CCAnimate actionWithAnimation:animation];
    [sprite runAction:[CCRepeatForever actionWithAction:animate]];
    sprite.flipX = YES;
    sprite.position = [self pointByRow:0 andCol:1];
    sprite.position = ccp(sprite.position.x, sprite.position.y + _h + _h);
    [self addChild:sprite];
}

- (void)sorcerer {
    CCSprite *sprite = [CCSprite node];
    id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"sorcerer_idle1"];
    id animate = [CCAnimate actionWithAnimation:animation];
    [sprite runAction:[CCRepeatForever actionWithAction:animate]];
    sprite.flipX = YES;
    sprite.position = [self pointByRow:0 andCol:2];
    sprite.position = ccp(sprite.position.x, sprite.position.y + _h + _h);
    [self addChild:sprite];
}

- (void)archer {
    CCSprite *sprite = [CCSprite node];
    sprite.position = [self pointByRow:5 andCol:0];
    sprite.position = ccp(sprite.position.x, sprite.position.y + _h);
    [self addChild:sprite];

    id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"archer_move2"];
    id animate = [CCAnimate actionWithAnimation:animation];
    id move = [CCRepeatForever actionWithAction:animate];
    [move setTag:2];

    [sprite runAction:move];

    id actionCallFuncN = [CCCallFuncN actionWithTarget:self selector:@selector(archerTask:)];
    id left = [CCMoveTo actionWithDuration:10.f position:[self pointByRow:0 andCol:0]];
    [sprite runAction:[CCSequence actionOne:left two:actionCallFuncN]];
}

- (void)archerTask:(id)node {
    CCSprite *sprite = node;

    if ([sprite getActionByTag:2] != nil) {
        [sprite stopActionByTag:2];

        sprite.flipX = YES;
        id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"archer_move1"];
        id animate = [CCAnimate actionWithAnimation:animation];
        id move = [CCRepeatForever actionWithAction:animate];
        [move setTag:1];

        [sprite runAction:move];

        id actionCallFuncN = [CCCallFuncN actionWithTarget:self selector:@selector(archerTask:)];
        id right = [CCMoveTo actionWithDuration:10.f position:[self pointByRow:5 andCol:0]];
        [sprite runAction:[CCSequence actionOne:right two:actionCallFuncN]];
    } else {
        [sprite stopActionByTag:1];

        sprite.flipX = NO;
        id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"archer_move2"];
        id animate = [CCAnimate actionWithAnimation:animation];
        id move = [CCRepeatForever actionWithAction:animate];
        [move setTag:2];

        [sprite runAction:move];

        id actionCallFuncN = [CCCallFuncN actionWithTarget:self selector:@selector(archerTask:)];
        id left = [CCMoveTo actionWithDuration:10.f position:[self pointByRow:0 andCol:0]];
        [sprite runAction:[CCSequence actionOne:left two:actionCallFuncN]];
    }
}

- (void)scout {
    CCSprite *sprite = [CCSprite node];
    sprite.position = [self pointByRow:0 andCol:0];
    sprite.position = ccp(sprite.position.x, sprite.position.y + _h);
    [self addChild:sprite];

    sprite.flipX = YES;
    id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"scout_move1"];
    id animate = [CCAnimate actionWithAnimation:animation];
    id move = [CCRepeatForever actionWithAction:animate];
    [move setTag:1];

    [sprite runAction:move];

    id actionCallFuncN = [CCCallFuncN actionWithTarget:self selector:@selector(scoutTask:)];
    id right = [CCMoveTo actionWithDuration:10.f position:[self pointByRow:5 andCol:0]];
    [sprite runAction:[CCSequence actionOne:right two:actionCallFuncN]];
}

- (void)scoutTask:(id)node {
    CCSprite *sprite = node;

    if ([sprite getActionByTag:2] != nil) {
        [sprite stopActionByTag:2];

        sprite.flipX = YES;
        id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"scout_move1"];
        id animate = [CCAnimate actionWithAnimation:animation];
        id move = [CCRepeatForever actionWithAction:animate];
        [move setTag:1];

        [sprite runAction:move];

        id actionCallFuncN = [CCCallFuncN actionWithTarget:self selector:@selector(scoutTask:)];
        id right = [CCMoveTo actionWithDuration:10.f position:[self pointByRow:5 andCol:0]];
        [sprite runAction:[CCSequence actionOne:right two:actionCallFuncN]];
    } else {
        [sprite stopActionByTag:1];

        sprite.flipX = NO;
        id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"scout_move2"];
        id animate = [CCAnimate actionWithAnimation:animation];
        id move = [CCRepeatForever actionWithAction:animate];
        [move setTag:2];

        [sprite runAction:move];

        id actionCallFuncN = [CCCallFuncN actionWithTarget:self selector:@selector(scoutTask:)];
        id left = [CCMoveTo actionWithDuration:10.f position:[self pointByRow:0 andCol:0]];
        [sprite runAction:[CCSequence actionOne:left two:actionCallFuncN]];
    }
}

- (void)knight {
    CCSprite *sprite = [CCSprite node];
    id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"knight_idle1"];
    id animate = [CCAnimate actionWithAnimation:animation];
    [sprite runAction:[CCRepeatForever actionWithAction:animate]];
    sprite.position = [self pointByRow:2 andCol:8];
    sprite.position = ccp(sprite.position.x, sprite.position.y + _h);
    [self addChild:sprite];
}

- (void)soldier {
    CCSprite *sprite = [CCSprite node];
    id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"soldier_idle1"];
    id animate = [CCAnimate actionWithAnimation:animation];
    [sprite runAction:[CCRepeatForever actionWithAction:animate]];
    sprite.position = [self pointByRow:1 andCol:8];
    sprite.position = ccp(sprite.position.x, sprite.position.y + _h);
    [self addChild:sprite];
}

- (void)paladin {
    CCSprite *sprite = [CCSprite node];
    id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"paladin_idle1"];
    id animate = [CCAnimate actionWithAnimation:animation];
    [sprite runAction:[CCRepeatForever actionWithAction:animate]];
    sprite.position = [self pointByRow:3 andCol:8];
    sprite.position = ccp(sprite.position.x, sprite.position.y + _h);
    [self addChild:sprite];
}

- (void)warrior {
    CCSprite *sprite = [CCSprite node];
    id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"warrior_idle1"];
    id animate = [CCAnimate actionWithAnimation:animation];
    [sprite runAction:[CCRepeatForever actionWithAction:animate]];
    sprite.position = [self pointByRow:4 andCol:8];
    sprite.position = ccp(sprite.position.x, sprite.position.y + _h);
    [self addChild:sprite];
}

- (void)ninja {
    CCSprite *sprite = [CCSprite node];
    id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"ninja_idle1"];
    id animate = [CCAnimate actionWithAnimation:animation];
    [sprite runAction:[CCRepeatForever actionWithAction:animate]];
    sprite.flipX = YES;
    sprite.position = [self pointByRow:0 andCol:5];
    sprite.position = ccp(sprite.position.x, sprite.position.y + _h + _h);
    [self addChild:sprite];
}

- (void)assassin {
    CCSprite *sprite = [CCSprite node];
    id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"assassin_idle1"];
    id animate = [CCAnimate actionWithAnimation:animation];
    [sprite runAction:[CCRepeatForever actionWithAction:animate]];
    sprite.flipX = YES;
    sprite.position = [self pointByRow:0 andCol:6];
    sprite.position = ccp(sprite.position.x, sprite.position.y + _h + _h);
    [self addChild:sprite];
}

- (void)cannoneer {
    CCSprite *sprite = [CCSprite node];
    id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"cannoneer_idle1"];
    id animate = [CCAnimate actionWithAnimation:animation];
    [sprite runAction:[CCRepeatForever actionWithAction:animate]];
    sprite.flipX = YES;
    sprite.position = [self pointByRow:0 andCol:4];
    sprite.position = ccp(sprite.position.x, sprite.position.y + _h);
    [self addChild:sprite];
}

- (void)sniper {
    CCSprite *sprite = [CCSprite node];
    id animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"sniper_skl01"];
    id animate = [CCAnimate actionWithAnimation:animation];
    [sprite runAction:[CCRepeatForever actionWithAction:animate]];
    sprite.flipX = YES;
    sprite.position = [self pointByRow:0 andCol:3];
    sprite.position = ccp(sprite.position.x, sprite.position.y + _h);
    [self addChild:sprite];
}


- (CGPoint)pointByRow:(int)row andCol:(int)col {
    return ccp(_x0 + _w * (col + row), _y0 + _h * (col - row));
}

@end
