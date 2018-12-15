//
//  CommonTool.m
//  F2Pool
//
//  Created by 韩冲 on 2018/5/14.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "CommonTool.h"

@implementation CommonTool

+ (void)setBackgroundColors:(NSArray <UIColor *> *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint forView:(UIView *)view
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    NSMutableArray *marrC = [NSMutableArray array];
    NSMutableArray *marrL = [NSMutableArray array];
    for (int i = 0; i < colors.count; i ++) {
        [marrC addObject:(__bridge id)colors[i].CGColor];
        [marrL addObject:@(i * 1.0/(colors.count - 1))];
    }
    gradientLayer.colors = [marrC copy];
    gradientLayer.locations = [marrL copy];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = view.bounds;
    [view.layer insertSublayer:gradientLayer atIndex:0];
}

@end
