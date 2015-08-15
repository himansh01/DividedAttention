//
//  GamePlayLayer.m
//  DividedAttention
//
//  Created by Himanshu Arora on 15/08/15.
//  Copyright 2015 Himanshu Arora. All rights reserved.
//

#import "GamePlayLayer.h"
#import "MainMenuLayer.h"

#define kSpeed 2
#define kTotalObstacles 2
#define kMaxSpeed 2

@implementation GamePlayLayer

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    GamePlayLayer *layer = [GamePlayLayer node];
    [scene addChild: layer];
    return scene;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeVariables];
        [self addLayers];
        [self addCircles];
        [self addObstacles];
        [self scheduleUpdate];
        [self schedule:@selector(checkifRedCircleTouched) interval:3.0 repeat:-1 delay:0];
    }
    return self;
}

-(void)checkifRedCircleTouched{

    if (!isRedTouchedInTime) {
        [self callGameover];
    }
    isRedTouchedInTime=false;
    NSLog(@"---checking gameover");
}

-(void)initializeVariables{

    winSIze=[CCDirector sharedDirector].winSize;
    self.touchEnabled=true;
    obsArr=[[NSMutableArray alloc]init];
    speed=kSpeed;
}

-(void)addLayers{

    CCLayerColor* dummyLayer1=[CCLayerColor layerWithColor:ccc4(255,255,255,255)];
    dummyLayer1.position=ccp(0, 0);
    dummyLayer1.contentSize=CGSizeMake(winSIze.width*0.5, winSIze.height);
    [self addChild:dummyLayer1];
    
    CCLayerColor* dummyLayer2=[CCLayerColor layerWithColor:ccc4(67,255,205,255)];
    dummyLayer2.position=ccp(winSIze.width*0.5, 0);
    dummyLayer2.contentSize=CGSizeMake(winSIze.width*0.5, winSIze.height);
    [self addChild:dummyLayer2];
    
    layer1=[CCLayerColor layerWithColor:ccc4(255,255,255,255)];
    layer1.position=ccp(0, 0);
    layer1.contentSize=CGSizeMake(winSIze.width*0.5, winSIze.height);
    [self addChild:layer1];
    
    layer1_2=[CCLayerColor layerWithColor:ccc4(255,255,255,255)];
    layer1_2.position=ccp(0, winSIze.height);
    layer1_2.contentSize=CGSizeMake(winSIze.width*0.5, winSIze.height);
    [self addChild:layer1_2];
    
    layer2=[CCLayerColor layerWithColor:ccc4(67,255,205,255)];
    layer2.position=ccp(winSIze.width*0.5, 0);
    layer2.contentSize=CGSizeMake(winSIze.width*0.5, winSIze.height);
    [self addChild:layer2];
    
    layer2_2=[CCLayerColor layerWithColor:ccc4(67,255,205,255)];
    layer2_2.position=ccp(winSIze.width*0.5, winSIze.height);
    layer2_2.contentSize=CGSizeMake(winSIze.width*0.5, winSIze.height);
    [self addChild:layer2_2];
    
//    CCSprite* blueCircle1=[CCSprite spriteWithFile:@"black_circle.png"];
//    blueCircle1.position=ccp(winSIze.width*0.25, winSIze.height*0.1);
//    [layer1 addChild:blueCircle1];
//    
//    CCSprite* redCircle1=[CCSprite spriteWithFile:@"red_circle.png"];
//    redCircle1.position=ccp(winSIze.width*0.25, winSIze.height*0.1);
//    [layer1_2 addChild:redCircle1];
    
    
//    CCMoveBy *mov1=[CCMoveBy actionWithDuration:2.0 position:ccp(0, -winSIze.height)];
//    [layer1 runAction:mov1];
//    CCMoveBy *mov2=[CCMoveBy actionWithDuration:2.0 position:ccp(0, -winSIze.height)];
//    [layer1_2 runAction:mov2];
}

-(void)addObstacles{

    for (int i=0; i<kTotalObstacles; i++) {
        
        CCSprite* obstacle=[CCSprite spriteWithFile:@"box.png"];
        [layer1_2 addChild:obstacle];
        
        float diff = winSIze.width*0.35-obstacle.boundingBox.size.width*0.5;
        float randPosX = (((float) rand() / RAND_MAX) * diff) + obstacle.boundingBox.size.width*0.5;
        
        float diffY = winSIze.height*0.15-winSIze.height*0.02;
        float randPosY= (((float) rand() / RAND_MAX) * diffY) + obstacle.boundingBox.size.width*0.5;
//        randPosX=layer1.boundingBox.size.width*0.5;
        obstacle.position=ccp(randPosX,(winSIze.height*0.85/kTotalObstacles)*i+randPosY);
        
        [obsArr addObject:obstacle];
//        [self moveObstacle:obstacle];
    }
    
    for (int i=0; i<kTotalObstacles; i++) {
        
        CCSprite* obstacle=[CCSprite spriteWithFile:@"box.png"];
        [layer1 addChild:obstacle];
        
        float diffY = winSIze.height*0.15-winSIze.height*0.02;
        float randPosY= (((float) rand() / RAND_MAX) * diffY) + obstacle.boundingBox.size.width*0.5;
        
        float diff = winSIze.width*0.35-obstacle.boundingBox.size.width*0.5;
        float randPosX = (((float) rand() / RAND_MAX) * diff) + obstacle.boundingBox.size.width*0.5;
//        randPosX=layer1.boundingBox.size.width*0.5;
        obstacle.position=ccp(randPosX,(winSIze.height*0.9/kTotalObstacles)*i+winSIze.height*0.05+randPosY);
        [obsArr addObject:obstacle];
        obstacle.visible=false;
        //        [self moveObstacle:obstacle];
    }
    
    for (int i=0; i<kTotalObstacles; i++) {
        
        CCSprite* obstacle=[CCSprite spriteWithFile:@"box.png"];
        [layer2_2 addChild:obstacle];
        
        float diff = winSIze.width*0.35-obstacle.boundingBox.size.width*0.5;
        float randPosX = (((float) rand() / RAND_MAX) * diff) + obstacle.boundingBox.size.width*0.5;
//        randPosX=layer1.boundingBox.size.width*0.5;
        obstacle.position=ccp(randPosX,(winSIze.height/kTotalObstacles)*i+winSIze.height*0.05);
        
        [obsArr addObject:obstacle];
        //        [self moveObstacle:obstacle];
    }
    
    for (int i=0; i<kTotalObstacles; i++) {
        
        CCSprite* obstacle=[CCSprite spriteWithFile:@"box.png"];
        [layer2 addChild:obstacle];
        
        float diff = winSIze.width*0.35-obstacle.boundingBox.size.width*0.5;
        float randPosX = (((float) rand() / RAND_MAX) * diff) + obstacle.boundingBox.size.width*0.5;
//        randPosX=layer1.boundingBox.size.width*0.5;
        obstacle.position=ccp(randPosX,(winSIze.height*0.9/kTotalObstacles)*i+winSIze.height*0.05);
        [obsArr addObject:obstacle];
        obstacle.visible=false;
        //        [self moveObstacle:obstacle];
    }
}

-(void)moveObstacle:(CCSprite *)obs{

    CCMoveBy *mov=[CCMoveBy actionWithDuration:10 position:ccp(obs.position.x, -winSIze.height*2)];
    [obs runAction:mov];
}

//-(void)moveLayers:(BOOL)isLayer1{
//
//    if (isLayer1) {
//        CCMoveBy *mov1=[CCMoveBy actionWithDuration:2.0 position:ccp(0, -winSIze.height)];
//        [layer1 runAction:mov1];
//    }
//    else{
//        CCMoveBy *mov2=[CCMoveBy actionWithDuration:2.0 position:ccp(0, -winSIze.height)];
//        [layer1_2 runAction:mov2];
//    }
//}

-(void)addCircles{

    blueCircle=[CCSprite spriteWithFile:@"blue_circle.png"];
    blueCircle.position=ccp(winSIze.width*0.25, winSIze.height*0.1);
    blueCircle.scale=1.3;
    [self addChild:blueCircle];
    
    redCircle=[CCSprite spriteWithFile:@"red_circle.png"];
    redCircle.position=ccp(winSIze.width*0.75, winSIze.height*0.1);
    redCircle.scale=1.3;
    [self addChild:redCircle];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint touchBeganPos = [touch locationInView: [touch view]];
    touchBeganPos = [[CCDirector sharedDirector] convertToGL: touchBeganPos];
    isTouched=true;
    
    if (touchBeganPos.x<winSIze.width*0.5) {
        NSLog(@"Left Screen touched");
    }
    else{
        NSLog(@"right Screen touched");
    }
    
    if (CGRectContainsPoint(redCircle.boundingBox, touchBeganPos)) {
        isRightCircleTouched=true;
        isRedTouchedInTime=true;
//        [self moveRightScreen];
    }
    
    if (CGRectContainsPoint(blueCircle.boundingBox, touchBeganPos)) {
        isLeftCircleTouched=true;
        [self blueCircleJump];
    }
}

-(void)moveRightScreen{

//    CCMoveBy *mov=[CCMoveBy actionWithDuration:0.2 position:-winSIze.height*0.2];
}

-(void)blueCircleJump{

    if (!isPlayerJumping) {
        isPlayerJumping=true;
        CCScaleBy *scl=[CCScaleBy actionWithDuration:0.5 scale:1.5];
        CCActionInterval *revScl=[scl reverse];
        CCCallBlock *block=[CCCallBlock actionWithBlock:^{
        
            isPlayerJumping=false;
        }];
        CCSequence *seq=[CCSequence actions:scl,revScl,block, nil];
        [blueCircle runAction:seq];
    }
    
}

-(void)redCircleJump{
    
    if (!isPlayer2Jumping) {
        isPlayer2Jumping=true;
        CCScaleBy *scl=[CCScaleBy actionWithDuration:0.5 scale:1.5];
        CCActionInterval *revScl=[scl reverse];
        CCCallBlock *block=[CCCallBlock actionWithBlock:^{
            
            isPlayer2Jumping=false;
        }];
        CCSequence *seq=[CCSequence actions:scl,revScl,block, nil];
        [redCircle runAction:seq];
    }
    
}

//-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    
//    UITouch *touch = [touches anyObject];
//    CGPoint touchMovPos = [touch locationInView: [touch view]];
//    touchMovPos = [[CCDirector sharedDirector] convertToGL: touchMovPos];
//    
//    if (CGRectContainsPoint(redCircle.boundingBox, touchMovPos)) {
//        isRightCircleTouched=true;
//        [self moveRightScreen];
//    }
//    else{
//        isRightCircleTouched=false;
//    }
//    
//    if (!CGRectContainsPoint(redCircle.boundingBox, touchMovPos)) {
//        isLeftCircleTouched=false;
//        
//    }
//}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint touchEndPos = [touch locationInView: [touch view]];
    touchEndPos = [[CCDirector sharedDirector] convertToGL: touchEndPos];
    isTouched=false;
    isLeftCircleTouched=false;
    isRightCircleTouched=false;
    
    if (CGRectContainsPoint(redCircle.boundingBox, touchEndPos)) {
        touchEndOnRedCircle=true;
        [self redCircleJump];
        CCDelayTime *delay=[CCDelayTime actionWithDuration:0.8];
        CCCallBlock *block=[CCCallBlock actionWithBlock:^{
            touchEndOnRedCircle=false;
        }];
        CCSequence *seq=[CCSequence actions:delay,block, nil];
        [self runAction:seq];
//        [self moveRightScreen];
    }
}

-(void)update:(ccTime)delta{

//    auto-scrolling first half of screen
    layer1.position=ccp(layer1.position.x, layer1.position.y-speed);
    layer1_2.position=ccp(layer1_2.position.x, layer1_2.position.y-speed);
    
    if (isRightCircleTouched) {
        layer2.position=ccp(layer2.position.x, layer2.position.y-kSpeed*2);
        layer2_2.position=ccp(layer2_2.position.x, layer2_2.position.y-kSpeed*2);
    }
    
    else if (touchEndOnRedCircle) {
        layer2.position=ccp(layer2.position.x, layer2.position.y-kSpeed*2);
        layer2_2.position=ccp(layer2_2.position.x, layer2_2.position.y-kSpeed*2);
    }
    
    if (layer2.position.y<=-winSIze.height) {
        layer2.position=ccp(layer2.position.x, winSIze.height);
        for (CCSprite *obs in layer2.children) {
            obs.visible=true;
        }
    }
    
    if (layer2_2.position.y<=-winSIze.height) {
        layer2_2.position=ccp(layer2_2.position.x, winSIze.height);
    }
    
    if (layer1.position.y<=-winSIze.height) {
        if (speed<kMaxSpeed) {
            speed=speed+0.1;
        }
        
        layer1.position=ccp(layer1.position.x, winSIze.height);
        for (CCSprite *obs in layer1.children) {
            obs.visible=true;
        }
    }
    
    if (layer1_2.position.y<=-winSIze.height) {
        if (speed<kMaxSpeed) {
            speed=speed+0.1;
        }
        layer1_2.position=ccp(layer1_2.position.x, winSIze.height);
    }
    
    for (CCSprite *obs in obsArr) {
        
//        NSLog(@"--- %@",NSStringFromCGPoint(obs.position));
        CGPoint pos=[obs.parent convertToWorldSpace:obs.position];
//        NSLog(@"--- %@",NSStringFromCGPoint(pos));
        if (!isPlayerJumping && obs.visible && !isGameOver) {
        
            if (CGRectIntersectsRect(blueCircle.boundingBox, CGRectMake(pos.x-obs.boundingBox.size.width*0.5, pos.y-obs.boundingBox.size.height*0.5,obs.boundingBox.size.width,obs.boundingBox.size.height))) {
                
                [self callGameover];
            }
        }
        
        if (!isPlayer2Jumping && obs.visible && !isGameOver) {
            
            if (CGRectIntersectsRect(redCircle.boundingBox, CGRectMake(pos.x-obs.boundingBox.size.width*0.5, pos.y-obs.boundingBox.size.height*0.5,obs.boundingBox.size.width,obs.boundingBox.size.height))) {
                //            NSLog(@"--collision in left layer");
                [self callGameover];
                
            }
        }
        
    }
    
}

-(void)callGameover{

    isGameOver=true;
    [self unscheduleUpdate];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[MainMenuLayer scene] ]];
}

@end
