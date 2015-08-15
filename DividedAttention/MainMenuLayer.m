//
//  MainMenuLayer.m
//  DividedAttention
//
//  Created by Himanshu Arora on 15/08/15.
//  Copyright 2015 Himanshu Arora. All rights reserved.
//

#import "MainMenuLayer.h"
#import "GamePlayLayer.h"

@implementation MainMenuLayer
+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    MainMenuLayer *layer = [MainMenuLayer node];
    [scene addChild: layer];
    return scene;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        CCLayerColor* dummyLayer1=[CCLayerColor layerWithColor:ccc4(255,255,255,255)];
        dummyLayer1.position=ccp(0, 0);
//        dummyLayer1.contentSize=CGSizeMake(winSIze.width, winSIze.height);
        [self addChild:dummyLayer1];
        
        CCMenuItemSprite *playBtn=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"blue_circle.png"] selectedSprite:[CCSprite spriteWithFile:@"blue_circle.png"] block:^(id sender){
            
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[GamePlayLayer scene] ]];
        }];
        
        playBtn.scale=2.0;
        playBtn.position=ccp(winSIze.width*0.5, winSIze.height*0.5);
        
        CCMenu *menu=[CCMenu menuWithItems:playBtn, nil];
        [self addChild:menu];
        
        CCLabelTTF *playLbl=[CCLabelTTF labelWithString:@"PLAY" fontName:@"arial" fontSize:winSIze.width*0.02];
        playLbl.color=ccWHITE;
        playLbl.position=ccp(playBtn.boundingBox.size.width*0.5, playBtn.boundingBox.size.height*0.5);
        [playBtn addChild:playLbl];
    }
    return self;
}
@end
