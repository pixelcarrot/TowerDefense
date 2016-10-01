//
//  MainLayer.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 3/5/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "MainLayer.h"
#import "MapLayer.h"
#import "AboutLayer.h"

@implementation MainLayer {
    CCSprite *startgame, *about;
}

+ (CCScene *)scene {
    CCScene *scene = [CCScene node];
    MainLayer *layer = [MainLayer node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    if ((self = [super init])) {

        CGSize size = [[CCDirector sharedDirector] winSize];

        // load hình nền
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"main_background.jpg"];

        // load nút start và about

        about = [CCSprite spriteWithSpriteFrameName:@"btn_about.png"];
        startgame = [CCSprite spriteWithSpriteFrameName:@"btn_startgame.png"];
        // chỉnh vị trí hình nền là center
        background.position = ccp(size.width / 2, size.height / 2);

        // thêm hình nền, nút start, about vào màn hình
        [self addChild:background];
        //[self addChild: startgame];
        [self addChild:about];
        [self addChild:startgame];
        id moveStartgame, moveAbout;

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            // nếu là iphone
            //startgame.position = ccp(size.width/2,0);
            about.position = ccp(size.width / 2, 200);
            startgame.position = ccp(size.width / 2, 310);

            // khởi tạo animation di chuyển của nút start và about

            moveAbout = [CCMoveTo actionWithDuration:1.5f position:ccp(size.width / 2, 30)];
            moveStartgame = [CCMoveTo actionWithDuration:1.5f position:ccp(size.width / 2, 70)];
        } else {
            // nếu là ipad
            startgame.position = ccp(size.width / 2, 277);
            about.position = ccp(size.width / 2, 174);

            // khởi tạo animation di chuyển của nút start và about
            moveStartgame = [CCMoveTo actionWithDuration:1.5f position:ccp(size.width / 2, 160)];
            moveAbout = [CCMoveTo actionWithDuration:1.5f position:ccp(size.width / 2, 60)];
        }

        // thực hiện animation 2 nút start và about

        [about runAction:moveAbout];
        [startgame runAction:moveStartgame];
        // cho phép sự kiện touch 
        self.touchEnabled = YES;
    }

    return self;
}

- (void)registerWithTouchDispatcher {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

// bắt đầu chàm vào màn hình 
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    //lấy toạ dộ chạm vào màn hình
    CGPoint touchPoint = [self convertTouchToNodeSpace:touch];

    // so sánh nếu toạ độ nằm trong hình chữ nhật của nút start và about 
    if (CGRectContainsPoint(startgame.boundingBox, touchPoint)) {

        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MapLayer scene]]];

    } else if (CGRectContainsPoint(about.boundingBox, touchPoint)) {

        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[AboutLayer scene]]];

    }

    return YES;
}




/*
-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
}
 */

@end
