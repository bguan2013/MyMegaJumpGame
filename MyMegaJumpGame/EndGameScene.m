//
//  EndGameScene.m
//  MyMegaJumpGame
//
//  Created by Bo Guan on 4/13/15.
//  Copyright (c) 2015 Bo Guan. All rights reserved.
//

#import "EndGameScene.h"

@interface EndGameScene (){
    
    SKLabelNode *_scoreLabel;
    SKLabelNode *_starLabel;
    
    SKSpriteNode *_mainMenuButton;
    SKSpriteNode *_replayButton;
    
}

@end

@implementation EndGameScene

-(id)initWithSize:(CGSize)size{
    
    if (self = [super initWithSize:size]) {
        
        
        _scoreLabel = [self createScoreLabel];
        _starLabel = [self createStarLabel];
    
        [self addChild:_scoreLabel];
        [self addChild:_starLabel];
        
        
    }
    return self;
}


-(SKLabelNode *)createScoreLabel{
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"helveticaNeue"];
    scoreLabel.fontColor = [SKColor whiteColor];
    scoreLabel.fontSize = 30;
    [scoreLabel setText:[NSString stringWithFormat:@"Your Score: %d", [GameState sharedInstance].score]];
    scoreLabel.position = CGPointMake(self.size.width/2, self.size.height*3/4);
    return scoreLabel;
}

-(SKLabelNode *)createStarLabel{
    SKLabelNode *starLabel = [SKLabelNode labelNodeWithFontNamed:@"helveticaNeue"];
    starLabel.fontColor = [SKColor whiteColor];
    starLabel.fontSize = 30;
    [starLabel setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].numberOfStars]];
    starLabel.position = CGPointMake(self.size.width/2, self.size.height*2/3);
    return starLabel;
}


-(void)createMainMenuButton{
    
    
    
}

-(void)createReplayButton{
    
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    SKNode *temp = [self nodeAtPoint:[touch locationInNode:self]];
    if(temp == _mainMenuButton){
        
        
        
    }
    else if(temp == _replayButton){
        
        [self.view presentScene:[[MegaJumpFirstScene alloc] initWithSize:self.size] transition:[SKTransition fadeWithDuration:0.5]];
    }
}

@end
