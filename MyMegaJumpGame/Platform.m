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
            
            [player runAction:[SKAction sequence:@[[SKAction group:@[[SKAction runBlock:^(void){
                player.physicsBody.velocity = CGVectorMake(player.physicsBody.velocity.dx, 0.0f);
                [self removeFromParent];
            }],[SKAction scaleXTo:1.0f y:0.6f duration:0.03]]],[SKAction group:@[[SKAction scaleXTo:1.0f y:1.0f duration:0.03],[SKAction runBlock:^(void){
                player.physicsBody.velocity = CGVectorMake(player.physicsBody.velocity.dx, 250.0f);
            }]]]]]
             ];
            
            
        }
        
        else{
            
            [player runAction:[SKAction sequence:@[[SKAction group:@[[SKAction runBlock:^(void){
                player.physicsBody.velocity = CGVectorMake(player.physicsBody.velocity.dx, 0.0f);
            }],[SKAction scaleXTo:1.0f y:0.6f duration:0.03]]],[SKAction group:@[[SKAction scaleXTo:1.0f y:1.0f duration:0.03],[SKAction runBlock:^(void){
                player.physicsBody.velocity = CGVectorMake(player.physicsBody.velocity.dx, 250.0f);
            }]]]]]
             ];
        }
    }
    return NO;
    
}

@end
