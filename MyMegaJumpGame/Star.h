//
//  Star.h
//  MyMegaJumpGame
//
//  Created by Bo Guan on 4/11/15.
//  Copyright (c) 2015 Bo Guan. All rights reserved.
//

#import "GameObjectNode.h"

typedef NS_ENUM(int, StarCategory){
    
    StarCategoryNormal,
    StarCategorySpecial
    
};

@interface Star : GameObjectNode

@property (nonatomic, assign) StarCategory category;

@end
