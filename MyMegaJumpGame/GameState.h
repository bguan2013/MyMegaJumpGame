//
//  GameState.h
//  MyMegaJumpGame
//
//  Created by Bo Guan on 4/13/15.
//  Copyright (c) 2015 Bo Guan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameState : NSObject <NSCoding>

@property(nonatomic, assign) int level;
@property(nonatomic, assign) int score;
@property(nonatomic, assign) int highestScore;
@property(nonatomic, assign) int numberOfStars;

+(instancetype)sharedInstance;
-(void)saveState;
-(void)reset;

@end
