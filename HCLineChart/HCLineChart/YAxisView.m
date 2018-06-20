//
//  YAxisView.m
//  HCLineChart
//
//  Created by 韩冲 on 2018/5/30.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "YAxisView.h"

@interface YAxisView ()

@end

@implementation YAxisView

- (instancetype)initWithFrame:(CGRect)frame yMax:(CGFloat)yMax yMin:(CGFloat)yMin
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.yMax = yMax;
        self.yMin = yMin;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // 计算坐标轴的位置以及大小
    CGSize labelSize = [@"0.1" sizeWithAttributes:self.attr];
    CGFloat allLabelHeight = self.frame.size.height - xAxisTextGap - labelSize.height - topMargin;
    
    // Label做占据的高度
    // Label之间的间隙
    CGFloat labelMargin = (allLabelHeight - (numberOfYAxisElements ) * labelSize.height) / numberOfYAxisElements;
    
    // 添加Label
    for (int i = 0; i < numberOfYAxisElements + 1; i++) {
        CGFloat avgValue = (self.yMax - self.yMin) / numberOfYAxisElements;
        // 判断是不是小数
        if ([self isPureFloat:self.yMin + avgValue * i]) {
            CGSize yLabelSize = [[NSString stringWithFormat:@"%.1f", self.yMin + avgValue * i] sizeWithAttributes:self.attr];
            [[NSString stringWithFormat:@"%.1f", self.yMin + avgValue * i] drawInRect:
             CGRectMake(self.frame.size.width - 1 - yLabelSize.width - xAxisTextGap,
                        allLabelHeight + topMargin - (labelMargin + yLabelSize.height) * i - yLabelSize.height/2,
                        yLabelSize.width,
                        yLabelSize.height) withAttributes:self.attr];
        }
        else {
            CGSize yLabelSize = [[NSString stringWithFormat:@"%.0f", self.yMin + avgValue * i] sizeWithAttributes:self.attr];
            [[NSString stringWithFormat:@"%.0f", self.yMin + avgValue * i] drawInRect:
             CGRectMake(self.frame.size.width - 1 - yLabelSize.width - xAxisTextGap,
                        allLabelHeight + topMargin - (labelMargin + yLabelSize.height) * i - yLabelSize.height/2,
                        yLabelSize.width,
                        yLabelSize.height) withAttributes:self.attr];
        }
        
    }
}

@end
