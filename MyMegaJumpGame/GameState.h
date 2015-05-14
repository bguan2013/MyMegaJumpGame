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
@property(nonatomic, assign) int highestScoreOne;
@property(nonatomic, assign) int highestScoreTwo;
@property(nonatomic, assign) int highestScoreThree;
@property(nonatomic, assign) int numberOfStars;

+(instancetype)sharedInstance;
-(void)saveState;
-(void)reset;
-(int)getHighScoreFromLevel:(int) level;
-(void)updateHighScoreInLevel:(int) level WithHighScore:(int) highscore;
-(void)loadInitialStateWithLevel:(int) level;
@end
