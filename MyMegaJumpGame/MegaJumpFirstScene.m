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

@interface MegaJumpFirstScene() <SKPhysicsContactDelegate> {
    
    SKNode *_backgroundNode;
    SKNode *_midgroundNode;
    SKNode *_foregroundNode;
    SKNode *_hudNode;
    SKNode *_player;
    
}

@end

@implementation MegaJumpFirstScene

-(instancetype)initWithSize:(CGSize)size{
    if (self == [super initWithSize:size]) {
        self.backgroundColor = [SKColor whiteColor];
        self.physicsWorld.gravity = CGVectorMake(0.0f, -2.0f);
        self.physicsWorld.contactDelegate = self;
        
        //Background
        _backgroundNode = [self createBackgroundNode];
        [self addChild:_backgroundNode];
        
        //Foreground
        _foregroundNode = [SKNode node];
        _player = [self createPlayer];
        [_foregroundNode addChild: _player];
        [self addChild: _foregroundNode];
        
        //Hud
        _hudNode = [self createHudNode];
        [self addChild:_hudNode];
        
        //Star
        Star *star = [self createStarAtPosition:CGPointMake(160.0f, 200.0f) withCategory:0];
        [self addChild:star];
        
        //Platform
        Platform *platform = [self createPlatformAtPosition:CGPointMake(160.0f, 250.0f) withCategory:0];
        [self addChild:platform];
        
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

-(SKNode *)createHudNode{
    
    SKNode *node = [SKNode node];
    SKSpriteNode *imageNode = [SKSpriteNode spriteNodeWithImageNamed:@"TapToStart"];
    imageNode.position = CGPointMake(160.0f, 180.0f);
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
    SKSpriteNode *starImageNode = [SKSpriteNode spriteNodeWithImageNamed:@"Star"];
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
        return;
    }
    else{
        [_hudNode removeFromParent];
        _player.physicsBody.dynamic = YES;
        [_player.physicsBody applyImpulse:CGVectorMake(0.0f, 100.0f)];
        
    }
    
}

@end
