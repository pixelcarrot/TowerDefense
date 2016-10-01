//
//  HealthComponent.h
//  Tower Defense
//
//  Created by Nguyen Hoang Anh Nguyen on 1/31/14.
//  Copyright (c) 2014 Nguyen Hoang Anh Nguyen. All rights reserved.
//

#import "Component.h"

@interface HealthComponent : Component {
    float _current;
    float _max;
}

@property float current;
@property float max;

- (id)initWithCurHp:(float)curHP maxHp:(float)maxHP;

- (BOOL)alive;

- (float)percentage;

@end
