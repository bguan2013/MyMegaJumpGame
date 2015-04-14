//
//  MegaJumpFirstScene.m
//  MyMegaJumpGame
//
//  Created by Bo Guan on 4/6/15.
//  Copyright (c) 2015 Bo Guan. All rights reserved.
//

#import "MegaJumpFirstScene.h"

typedef NS_OPTIONS(uint32_t, Category){
    
    CategoryPlayer = 0x1 << 0,
    CategoryStar   = 0x1 << 1,
    CategoryPlatform = 0x1 << 2
};

typedef NS_ENUM(int, PlayerMovement){
    PlayerMovementNone = 0,
    PlayerMovementLeft = 1,
    PlayerMovementRight = 2
};

@interface MegaJumpFirstScene() <SKPhysicsContactDelegate> {
    

    CGVector _playerVelocity;
    SKNode *_backgroundNode;
    SKNode *_midgroundNode;
    SKNode *_foregroundNode;
    SKNode *_hudNode;
    SKNode *_player;
    int _endY;
    PlayerMovement _movement;
    
}

@end

@implementation MegaJumpFirstScene

-(id)initWithSize:(CGSize)size{
    
    if (self = [super initWithSize:size]) {
        
        
        NSString *levelOnePlist = [[NSBundle mainBundle] pathForResource:@"Level01" ofType:@"plist"];
        NSDictionary *levelOneInformation = [NSDictionary dictionaryWithContentsOfFile:levelOnePlist];
        
        //Variable initiation
        _playerVelocity = CGVectorMake(0.0f, 20.0f);
        _endY = [levelOneInformation[@"EndY"] intValue];
        _movement = PlayerMovementNone;
        
        NSDictionary *stars = levelOneInformation[@"Stars"];
        NSDictionary *starPatterns = stars[@"Patterns"];
        NSArray *starPositions = stars[@"Positions"];

        NSDictionary *platforms = levelOneInformation[@"Platforms"];
        NSDictionary *platformPatterns = platforms[@"Patterns"];
        NSArray *platformPositions = platforms[@"Positions"];
        
        
        
        self.backgroundColor = [SKColor whiteColor];
        self.physicsWorld.gravity = CGVectorMake(0.0f, -2.0f);
        self.physicsWorld.contactDelegate = self;
        
        //Background
        _backgroundNode = [self createBackgroundNode];
        [self addChild:_backgroundNode];
        
        //Midground
        _midgroundNode = [self createMidgroundNode];
        [self addChild:_midgroundNode];
        
        //Foreground
        _foregroundNode = [SKNode node];
        _player = [self createPlayer];
        [_foregroundNode addChild: _player];
        [self addChild: _foregroundNode];
        
        
        
        //Hud
        _hudNode = [self createHudNode];
        [self addChild:_hudNode];
        
        //Star
        for (NSDictionary *starPosition in starPositions) {
            
            CGFloat positionX = [starPosition[@"x"] floatValue];
            CGFloat positionY = [starPosition[@"y"] floatValue];
            NSString *pattern = starPosition[@"pattern"];
            
            NSArray *patternInformation = starPatterns[pattern];
            for (NSDictionary *starPattern in patternInformation) {
                
                CGFloat patternX = [starPattern[@"x"] floatValue];
                CGFloat patternY = [starPattern[@"y"] floatValue];
                StarCategory patternStarCategory = [starPattern[@"type"] intValue];
                Star *star = [self createStarAtPosition:CGPointMake(patternX + positionX, patternY + positionY) withCategory:patternStarCategory];
                [_foregroundNode addChild:star];
            }
            
        }
        
        //Platform
        for (NSDictionary *platformPosition in platformPositions) {
            CGFloat positionX = [platformPosition[@"x"] floatValue];
            CGFloat positionY = [platformPosition[@"y"] floatValue];
            NSString *pattern = platformPosition[@"pattern"];
            
            NSArray *patternInformation = platformPatterns[pattern];
            for (NSDictionary *platformPattern in patternInformation) {
                CGFloat patternX = [platformPattern[@"x"] floatValue];
                CGFloat patternY = [platformPattern[@"y"] floatValue];
                PlatformCategory patternPlatformCategory = [platformPattern[@"type"] intValue];
                
                Platform *platform = [self createPlatformAtPosition:CGPointMake(positionX + patternX, positionY + patternY) withCategory:patternPlatformCategory];
                [_foregroundNode addChild:platform];
            }
        }
        
        
    }
    
    return self;
}

-(SKNode *) createBackgroundNode{

    SKNode *backgroundNode = [SKNode node];
    
    for (int i = 0; i < 20; i++) {
        NSString *imageName = [NSString stringWithFormat:@"Background%02d", i+1];
        SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        node.anchorPoint = CGPointMake(0.5f, 0.0f);
        node.position = CGPointMake(160.0f, 64.0f*i);
        [backgroundNode addChild:node];
    }
    
    return backgroundNode;

}

-(SKNode *) createMidgroundNode{
    
    SKNode *midgroundNode = [SKNode node];
    
    for (int i = 0; i < 10; i++) {
        NSString *spriteName;
        
        int r = arc4random()%2;
        
        if(r > 0){
            
            spriteName = @"BranchRight";
            
            
        }
        else{
            spriteName = @"BranchLeft";
        }
        
        SKSpriteNode *branchNode = [SKSpriteNode spriteNodeWithImageNamed:spriteName];
        branchNode.position = CGPointMake(160.0f, 500.0f * i);
        [midgroundNode addChild:branchNode];
    }
    
    return midgroundNode;
    
}

-(SKNode *)createHudNode{
    
    SKNode *node = [SKNode node];
    SKSpriteNode *imageNode = [SKSpriteNode spriteNodeWithImageNamed:@"TapToStart"];
    imageNode.position = CGPointMake(160.0f, 180.0f);
    [imageNode setName:@"Start"];
    [node addChild: imageNode];
    return node;

}

-(Player *)createPlayer{
    
    
    Player *player = [Player node];
    [player setPosition: CGPointMake(160.0f, 80.0f)];
    SKSpriteNode *playerNode = [SKSpriteNode spriteNodeWithImageNamed:@"Player"];
    [player addChild:playerNode];
    player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:playerNode.size.height/2];
    player.physicsBody.dynamic = NO;
    player.physicsBody.allowsRotation = NO;
    player.physicsBody.friction = 0.0f;
    player.physicsBody.restitution = 1.0f;
    player.physicsBody.angularDamping = 0.0f;
    player.physicsBody.linearDamping = 0.0f;
    player.physicsBody.usesPreciseCollisionDetection = YES;
    player.physicsBody.categoryBitMask = CategoryPlayer;
    player.physicsBody.collisionBitMask = 0;
    
    //Notify developer when these object collide
    player.physicsBody.contactTestBitMask = CategoryPlatform|CategoryStar;
    
    
    return player;
}


-(Star *)createStarAtPosition: (CGPoint)point withCategory:(int) category{
    
    Star *star = [Star node];
    [star setPosition: point];
    [star setCategory:category];
    SKSpriteNode *starImageNode;
    if (category == StarCategoryNormal) {
        starImageNode = [SKSpriteNode spriteNodeWithImageNamed:@"Star"];
    }
    else{
        starImageNode = [SKSpriteNode spriteNodeWithImageNamed:@"StarSpecial"];
    }
    star.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:starImageNode.size.width/2];
    
    star.physicsBody.dynamic = NO;
    [star addChild:starImageNode];
    star.physicsBody.categoryBitMask = CategoryStar;
    star.physicsBody.collisionBitMask = 0;
    //star.physicsBody.contactTestBitMask = CategoryPlayer;
    return star;
}

-(Platform *)createPlatformAtPosition:(CGPoint)position withCategory:(int) category{
    
    Platform *platform = [Platform node];
    [platform setPosition:position];
    platform.catergory = category;
    SKSpriteNode *platformImageNode;
    if(category == PlatformCategoryBreak){
        platformImageNode = [SKSpriteNode spriteNodeWithImageNamed:@"PlatformBreak"];
    }
    else{
        platformImageNode = [SKSpriteNode spriteNodeWithImageNamed:@"Platform"];
    }
    
    [platform addChild:platformImageNode];
    platform.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:platformImageNode.size.width/2];
    platform.physicsBody.dynamic = NO;
    platform.physicsBody.categoryBitMask = CategoryPlatform;
    platform.physicsBody.collisionBitMask = 0;
    return platform;
    
}



-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    BOOL updateHUD = NO;
    
    GameObjectNode *otherNodeThanPlayer = (GameObjectNode *)((contact.bodyA.node == _player)?contact.bodyB.node:contact.bodyA.node);
    
    updateHUD = [otherNodeThanPlayer collisionWithPlayer:_player];
    
    if(updateHUD){
        
        
    }
    
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if(_player.physicsBody.dynamic){
        
        if(touches.count == 1) {
            
            UITouch *touch = [touches anyObject];
            CGPoint touchPosition = [touch locationInNode:self];
            if (touchPosition.x <= self.size.width/2) {
                _movement = PlayerMovementLeft;
            }
            else{
                _movement = PlayerMovementRight;
            }
            
        }
    }
    else{
        if(touches.count == 1) {
            
            UITouch *touch = [touches anyObject];
            CGPoint touchPosition = [touch locationInNode:self];
            SKNode *startNode = [self nodeAtPoint:touchPosition];
            
            if ([startNode.name isEqualToString:@"Start"]) {
                [_hudNode removeFromParent];
                _player.physicsBody.dynamic = YES;
                [_player.physicsBody applyImpulse: _playerVelocity];
            }
            else{
                return;
            }
        }
        
        
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    _movement = PlayerMovementNone;
}

-(void)update:(NSTimeInterval)currentTime{
    
    
    if(_player.position.y > 240.0f){
        
        _backgroundNode.position = CGPointMake(0.0f,-((_player.position.y-240.0f)/10));
        _midgroundNode.position = CGPointMake(0.0f, -((_player.position.y-240.0f)/4));
        _foregroundNode.position = CGPointMake(0.0f,-(_player.position.y-240.0f));
    }
    
    if(_player.position.x < -20.0f){
        
        _player.position = CGPointMake((self.size.width - _player.position.x), _player.position.y);
    }
    else if(_player.position.x > self.size.width+20.0f){
        
        _player.position = CGPointMake((_player.position.x-self.size.width), _player.position.y);
    }
    
    if(_movement != PlayerMovementNone){
        if (_movement == PlayerMovementLeft) {
            [_player.physicsBody applyForce:CGVectorMake(-60.0f, 0.0f)];
        }
        else{
            //Right
            [_player.physicsBody applyForce:CGVectorMake(60.0f, 0.0f)];
            
        }
    }
    
}

@end
