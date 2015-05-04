//
//  GameState.m
//  MyMegaJumpGame
//
//  Created by Bo Guan on 4/13/15.
//  Copyright (c) 2015 Bo Guan. All rights reserved.
//

#import "GameState.h"

@implementation GameState

-(id)initWithLevel:(int) level{
    
    if(self = [super init]){
        
        [self loadInitialState: level];
        
    }
    
    return self;
    
}

+(instancetype)sharedInstance{
    
    static dispatch_once_t once = false;
    static GameState *instance = nil;
    
    dispatch_once(&once, ^{instance = [[super alloc] initWithLevel:1];});
    
    return instance;
}

-(void)loadInitialState:(int) level{
    
    self.score = 0;
    self.numberOfStars = 0;
    self.level = level;
}

-(void)saveState{
    
    
}

-(void)reset{
    
    self.score = 0;
    self.numberOfStars = 0;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    return self;
}


@end
