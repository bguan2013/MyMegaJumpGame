//
//  GameObjectNode.m
//  MyMegaJumpGame
//
//  Created by Bo Guan on 4/11/15.
//  Copyright (c) 2015 Bo Guan. All rights reserved.
//

#import "GameObjectNode.h"

@implementation GameObjectNode


//Update the HUD
-(BOOL)collisionWithPlayer:(SKNode *)player{
    
    return NO;
}

-(void)checkNodeRemoval:(CGFloat)playerY{
    
    if (playerY > self.position.y + 300.0f) {
        [self removeFromParent];
    }
}

@end
