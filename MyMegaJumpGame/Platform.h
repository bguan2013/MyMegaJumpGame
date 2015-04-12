//
//  Platform.h
//  MyMegaJumpGame
//
//  Created by Bo Guan on 4/12/15.
//  Copyright (c) 2015 Bo Guan. All rights reserved.
//

#import "GameObjectNode.h"

typedef NS_ENUM(int, PlatformCategory){
    
    PlatformCategoryNormal,
    PlatformCategoryBreak
    
};

@interface Platform : GameObjectNode

@property(nonatomic,assign) PlatformCategory catergory;

@end
