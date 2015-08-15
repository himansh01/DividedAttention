//
//  GamePlayLayer.h
//  DividedAttention
//
//  Created by Himanshu Arora on 15/08/15.
//  Copyright 2015 Himanshu Arora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GamePlayLayer : CCLayer {
    
    CGSize winSIze;
    CCLayerColor *layer1,*layer1_2,*layer2,*layer2_2;
    CCSprite *redCircle,*blueCircle;
    BOOL isTouched,isLeftCircleTouched,isRightCircleTouched,isPlayerJumping,isPlayer2Jumping,isGameOver,touchEndOnRedCircle,isRedTouchedInTime;
    NSMutableArray *obsArr;
    float speed;
}

+(CCScene *) scene;

@end
