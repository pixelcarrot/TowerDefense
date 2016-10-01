//
//  AppDelegate.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/2/14.
//  Copyright Nguyen Hoang Anh Nguyen 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate> {
    UIWindow *window_;
    MyNavigationController *navController_;

    CCDirectorIOS *__unsafe_unretained director_;                            // weak ref
}

@property(nonatomic, strong) UIWindow *window;
@property(readonly) MyNavigationController *navController;
@property(unsafe_unretained, readonly) CCDirectorIOS *director;

@end
