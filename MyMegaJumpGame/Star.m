//
//  Star.m
//  MyMegaJumpGame
//
//  Created by Bo Guan on 4/11/15.
//  Copyright (c) 2015 Bo Guan. All rights reserved.
//

#import "Star.h"

@interface Star (){
    
    SKAction *_starSound;
}

@end

@implementation Star

-(BOOL)collisionWithPlayer:(Player *)player{
    
    player.physicsBody.velocity = CGVectorMake(player.physicsBody.velocity.dx, 400.0f);
    [self.parent runAction:_starSound];
    if(self.category == StarCategoryNormal){
        [GameState sharedInstance].score += 20;
        [GameState sharedInstance].numberOfStars +=1;
    }
    //special
    else{
        [GameState sharedInstance].score += 100;
        [GameState sharedInstance].numberOfStars += 5;
        
    }
    [self removeFromParent];
    return YES;
    
}

-(id)init{
    
    if(self = [super init]){
        _starSound = [SKAction playSoundFileNamed:@"StarPing.wav" waitForCompletion:NO];
    }
    return self;
    
}

@end
