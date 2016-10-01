//
//  WeaponComponent.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/7/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "Component.h"

typedef enum {
    Bow, Canon, Sword, Arrow, Katana, Spear, Hammer, Rifle, Bullet, Blade, Slug, Staff, Electric, Poison, Bite
} Weapon;

@interface WeaponComponent : Component

@property(assign) float speed;
@property(assign) int damage;
@property(assign) Weapon weapon;
@property(assign) BOOL allow;

- (id)initWithWeapon:(Weapon)weapon damage:(int)damage speed:(float)speed;

@end
