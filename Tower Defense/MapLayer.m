//
//  MapLayer.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 3/5/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "MapLayer.h"
#import "MainLayer.h"
#import "GameLayer.h"

@implementation MapLayer {
    id pvrTexture;

    CCArray *_rings; // tập hợp mảng các hình tròn map
    CCLayer *_layer; // chứa background bản đồ
    CGPoint _oldPoint;
    CGPoint _newPoint;
    CGPoint _touchBegan; // toạ độ lần đầu chạm vào màn hình nhưng chưa nhấc tay lên
    float _outWidth, _outHeight; // kích thước chênh lệch giữa màn hình với hình bản đồ nếu bản đồ lớn hơn màn hình 
}

+ (CCScene *)scene {
    CCScene *scene = [CCScene node];
    MapLayer *layer = [MapLayer node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    if ((self = [super init])) {

        CGSize size = [[CCDirector sharedDirector] winSize];

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {

            // load resource bản đồ 
            pvrTexture = [[CCTextureCache sharedTextureCache] addImage:@"worldmap.pvr.ccz"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"worldmap.plist" texture:pvrTexture];

        } else {

            pvrTexture = [[CCTextureCache sharedTextureCache] addImage:@"worldmap-hd.pvr.ccz"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"worldmap-hd.plist" texture:pvrTexture];
        }

        // lấy hình bản đồ 
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"WorldMap.jpg"];

        // đặt tâm hình là góc trái bên dưới 
        background.anchorPoint = ccp(0, 0);
        _layer = [CCLayer node];

        // add hình bản đồ 
        [_layer addChild:background];
        [self addChild:_layer];

        // tính kích thước chênh lệch màn hình so với bản đồ 
        _outWidth = background.textureRect.size.width - size.width;
        _outHeight = background.textureRect.size.height - size.height;

        // cho camera canh giữa màn hình 
        [_layer.camera setCenterX:_outWidth / 2 centerY:_outHeight / 2 centerZ:-1];
        [_layer.camera setEyeX:_outWidth / 2 eyeY:_outHeight / 2 eyeZ:0];

        // load dữ liệu xml từ file data
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]; // dương dan den file
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath]; // load file
        NSDictionary *map = [dict objectForKey:@"WorldMap"];
        NSArray *array; // mảng chứa toạ độ hình tròn map

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            array = [map objectForKey:@"iPhone"];
        } else {
            array = [map objectForKey:@"iPad"];
        }

        // khởi tạo mảng toạ độ các hình tròn map 
        _rings = [[CCArray alloc] init];

        for (int i = 0; i < array.count; i++) {

            // lấy toạ độ x và y 
            NSArray *pos = [[array objectAtIndex:i] componentsSeparatedByString:@"-"];
            int x = [[pos objectAtIndex:0] integerValue];
            int y = [[pos objectAtIndex:1] integerValue];

            // lấy hình tròn map 
            CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"ring_%i.png", i + 1]];
            sprite.position = ccp(x, background.textureRect.size.height - y);
            sprite.tag = i + 1;
            // thêm hình tròn map vào bản đồ 
            [_layer addChild:sprite];

            // thêm hình tròn map vào mảng 
            [_rings addObject:sprite];
        }

        // cho phép sự kiện touch 
        self.touchEnabled = YES;
    }

    return self;
}

- (void)registerWithTouchDispatcher {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

// sự kiện touch vào màn hình
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [self convertTouchToNodeSpace:touch];

    _oldPoint = touchPoint;
    _touchBegan = touchPoint;

    return YES;
}

// sự kiện touch vào màn hình nhưng chưa nhấc tay lên mà tiếp tục di chuyển
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [self convertTouchToNodeSpace:touch];

    _newPoint = touchPoint;
    [self viewWithOlPoint:_oldPoint andNewPoint:_newPoint];
    _oldPoint = _newPoint;
}

- (double)distanceBetween:(CGPoint)first and:(CGPoint)second {
    return sqrt((first.x - second.x) * (first.x - second.x) + ((first.y - second.y)) * ((first.y - second.y)));
}

// sự kiện nhấc tay lên khỏi màn hình sau khi touch
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [self convertTouchToNodeSpace:touch];

    if ([self distanceBetween:touchPoint and:_touchBegan] < 10) {

        float x, y, z;
        [_layer.camera centerX:&x centerY:&y centerZ:&z];

        for (CCSprite *sprite in _rings) {

            if (CGRectContainsPoint(sprite.boundingBox, ccp(touchPoint.x + x, touchPoint.y + y))) {

                [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromTexture:pvrTexture];

                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"worldmap.pvr.ccz"];
                    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"worldmap.plist"];
                } else {
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"worldmap-hd.pvr.ccz"];
                    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"worldmap-hd.plist"];
                }

                [[CCDirector sharedDirector] replaceScene:
                        [CCTransitionFade transitionWithDuration:1.0 scene:[GameLayer sceneWithMap:sprite.tag]]];
            }
        }

    }

    _oldPoint = touchPoint;
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

@end
