//
//  Platform.m
//  MyMegaJumpGame
//
//  Created by Bo Guan on 4/12/15.
//  Copyright (c) 2015 Bo Guan. All rights reserved.
//

#import "Platform.h"

@implementation Platform

-(BOOL)collisionWithPlayer:(SKNode *)player{
    
    
    
    if(player.physicsBody.velocity.dy < 0.0f){
        if(self.catergory == PlatformCategoryBreak){
            [self removeFromParent];
        }
        
        else{
            player.physicsBody.velocity = CGVectorMake(player.physicsBody.velocity.dx, 250.0f);
        }
        
    }
    return NO;
    
}

@end
