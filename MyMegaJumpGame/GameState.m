//
//  GameState.m
//  MyMegaJumpGame
//
//  Created by Bo Guan on 4/13/15.
//  Copyright (c) 2015 Bo Guan. All rights reserved.
//

#import "GameState.h"



@implementation GameState

static NSString *const levelOneKey = @"LevelOne";
static NSString *const levelTwoKey = @"LevelTwo";
static NSString *const levelThreeKey = @"LevelThree";





+(instancetype)loadInstance{
    
    
    NSString *filePath = [GameState createFilePath];
    
    NSData *decodeData = [NSData dataWithContentsOfFile:filePath];
    
    if(decodeData){
        
        //unarchiveObjectWithData invokes the initWithCoder method
        GameState *gameState = [NSKeyedUnarchiver unarchiveObjectWithData:decodeData];
        return gameState;
    }
    else{
        return [[self alloc] init];
    }
    
}

+(instancetype)sharedInstance{
    
    static dispatch_once_t once = false;
    static GameState *instance = nil;
    
    dispatch_once(&once, ^{instance = [GameState loadInstance];});
    
    return instance;
}

-(void)loadInitialStateWithLevel:(int) level{
    
    self.score = 0;
    self.numberOfStars = 0;
    self.level = level;
    
}

-(void)updateHighScoreInLevel:(int) level WithHighScore:(int) highscore{
    switch (level) {
        case 1:
            if (highscore > [self getHighScoreFromLevel:level]) {
                self.highestScoreOne = highscore;
                [self saveState];
            }
            break;
        case 2:
            if (highscore > [self getHighScoreFromLevel:level]) {
                self.highestScoreTwo = highscore;
                [self saveState];
            }
            break;
        case 3:
            if (highscore > [self getHighScoreFromLevel:level]) {
                self.highestScoreThree = highscore;
                [self saveState];
            }
            break;
            
        
    }
    
}

-(int)getHighScoreFromLevel:(int) level{
    
    switch (level) {
        case 1:
            return self.highestScoreOne;
            break;
        case 2:
            return self.highestScoreTwo;
            break;
        case 3:
            return self.highestScoreThree;
            break;
        default:
            return 0;
            break;
    }
}

-(void)saveState{
    
    //Calls encodeWithCoder
    NSData *encodeData = [NSKeyedArchiver archivedDataWithRootObject:self];
    [encodeData writeToFile:[GameState createFilePath] atomically:YES];
    
}

-(void)reset{
    
    self.score = 0;
    self.numberOfStars = 0;
}

+(NSString *)createFilePath{
    
    static NSString *filePath = nil;
    if(!filePath){
        filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:@"MegaSave"];
    }
    
    return filePath;
}




-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInt:self.highestScoreOne forKey:levelOneKey];
    [aCoder encodeInt:self.highestScoreTwo forKey:levelTwoKey];
    [aCoder encodeInt:self.highestScoreThree forKey:levelThreeKey];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [self init];
    if(self){
        //NSLog(@"I'm here!");
        
        self.highestScoreOne = [aDecoder decodeIntForKey:levelOneKey];
        self.highestScoreTwo = [aDecoder decodeIntForKey:levelTwoKey];
        self.highestScoreThree = [aDecoder decodeIntForKey:levelThreeKey];
        //NSLog(@"%d, %d, %d\n", self.highestScoreOne, self.highestScoreTwo, self.highestScoreThree);
    }
    
   
    return self;
}


@end
