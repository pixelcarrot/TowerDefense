//
//  MeleeComponent.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 2/1/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "Component.h"

@interface MeleeComponent : Component {
    int _count;
}

@property int count;
@property(assign) float damage;
@property(unsafe_unretained) NSString *animation;
@property(unsafe_unretained) NSString *sound;

- (id)initWithDamage:(float)damage animation:(NSString *)animation sound:(NSString *)sound;

- (id)initWithDamage:(float)damage count:(int)count animation:(NSString *)animation sound:(NSString *)sound;

@end
