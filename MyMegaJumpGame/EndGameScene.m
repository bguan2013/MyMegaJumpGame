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
    SKSpriteNode *_star;
    
    SKLabelNode *_highScoreLabel;
    
    SKSpriteNode *_mainMenuButton;
    SKSpriteNode *_replayButton;
    
}

@end

@implementation EndGameScene

-(id)initWithSize:(CGSize)size{
    
    if (self = [super initWithSize:size]) {
        
        
        _scoreLabel = [self createScoreLabel];
        _starLabel = [self createStarLabel];
        _mainMenuButton = [self createMainMenuButton];
        _replayButton = [self createReplayButton];
        _star = [self createStar];
        _highScoreLabel = [self createHighScoreLabel];
        
        [self addChild:_scoreLabel];
        [self addChild:_starLabel];
        [self addChild:_mainMenuButton];
        [self addChild:_replayButton];
        [self addChild:_star];
        [self addChild:_highScoreLabel];
        
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
    [starLabel setText:[NSString stringWithFormat:@" = %d", [GameState sharedInstance].numberOfStars]];
    starLabel.position = CGPointMake(self.size.width/2, self.size.height*2/3);
    return starLabel;
}

-(SKLabelNode *)createHighScoreLabel{
    
    SKLabelNode *highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"helveticaNeue"];
    highScoreLabel.fontColor = [SKColor whiteColor];
    highScoreLabel.fontSize = 30;
    [highScoreLabel setText:[NSString stringWithFormat:@"Highest Score = %d", [[GameState sharedInstance] getHighScoreFromLevel:1]]];
    highScoreLabel.position = CGPointMake(self.size.width/2, self.size.height/2);
    
    return highScoreLabel;
}

-(SKSpriteNode *)createStar{
    
    SKSpriteNode *star = [SKSpriteNode spriteNodeWithImageNamed:@"Star"];
    star.position = CGPointMake(self.size.width*2/5 - 20, self.size.height*2/3 + 10);
    
    return star;
}


-(SKSpriteNode *)createMainMenuButton{
    
    SKSpriteNode *menu = [SKSpriteNode spriteNodeWithImageNamed:@"Menu"];
    menu.position = CGPointMake(self.size.width/4, self.size.height/4);
    
    return menu;
    
}

-(SKSpriteNode *)createReplayButton{
    
    SKSpriteNode *replay = [SKSpriteNode spriteNodeWithImageNamed:@"Replay"];
    replay.position = CGPointMake(self.size.width*3/4, self.size.height/4);
    
    return replay;
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    SKNode *temp = [self nodeAtPoint:[touch locationInNode:self]];
    if(temp == _mainMenuButton){
        
       //[self.view presentScene:<#(SKScene *)#> transition:<#(SKTransition *)#>];
        
    }
    else if(temp == _replayButton){
        
        
        
        [self.view presentScene:[[MegaJumpFirstScene alloc] initWithSize:self.size] transition:[SKTransition fadeWithDuration:0.5]];
    }
}

@end
