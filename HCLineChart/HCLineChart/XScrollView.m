//
//  XScrollView.m
//  HCLineChart
//
//  Created by 韩冲 on 2018/6/1.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "XScrollView.h"
#import "UIScrollView+UITouch.h"

@implementation XScrollView

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
//    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    CGPoint point = [touch locationInView:self]; 
    [self.xdelegate touchPoint:point];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
