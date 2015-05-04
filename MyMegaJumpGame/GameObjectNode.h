//
//  GameObjectNode.h
//  MyMegaJumpGame
//
//  Created by Bo Guan on 4/11/15.
//  Copyright (c) 2015 Bo Guan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"
#import "GameState.h"

@interface GameObjectNode : SKNode

-(BOOL)collisionWithPlayer: (SKNode *)player;
-(void)checkNodeRemoval: (CGFloat)playerY;
    
    


@end
