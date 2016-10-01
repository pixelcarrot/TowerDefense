//
//  WeaponComponent.m
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/7/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "WeaponComponent.h"

@implementation WeaponComponent

- (id)initWithWeapon:(Weapon)weapon damage:(int)damage speed:(float)speed {
    if ((self = [super init])) {
        self.weapon = weapon;
        self.damage = damage;
        self.speed = speed;
        self.allow = NO;
    }
    return self;
}

@end
