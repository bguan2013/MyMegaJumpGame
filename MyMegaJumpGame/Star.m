//
//  Star.m
//  MyMegaJumpGame
//
//  Created by Bo Guan on 4/11/15.
//  Copyright (c) 2015 Bo Guan. All rights reserved.
//

#import "Star.h"

@implementation Star

-(BOOL)collisionWithPlayer:(Player *)player{
    
    player.physicsBody.velocity = CGVectorMake(player.physicsBody.velocity.dx, 400.0f);
    [self removeFromParent];
    return YES;
    
}

@end
