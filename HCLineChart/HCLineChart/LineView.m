//
//  LineView.m
//  F2Pool
//
//  Created by 韩冲 on 2018/8/3.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "LineView.h"

@interface LineView ()

@property (nonatomic, strong) NSArray *arrPoints;
@property (nonatomic, strong) UIColor *color;

@end

@implementation LineView

- (instancetype)initWithFrame:(CGRect)frame valueArray:(NSArray*)valueArray edgeWidth:(CGFloat)edgeWidth yMax:(CGFloat)yMax yMin:(CGFloat)yMin color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.yMax = yMax;
        self.yMin = yMin;
        self.valueArray = valueArray;
        self.edgeWidth = edgeWidth;
        self.color = color;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (!self.valueArray || self.valueArray.count == 0) {
        return;
    }
    // 分为4个格  有5条分割线
    int noUseNum = self.valueArray.count % 4;
    int oneCaseNum = (int)(self.valueArray.count / 4);
    if (noUseNum) {
        noUseNum --;
    }
    else {
        noUseNum = 3;
        oneCaseNum --;
    }
    CGFloat pointGap = (self.frame.size.width - self.edgeWidth) / (self.valueArray.count - noUseNum - 1);
    /////////////////////// 根据数据源画折线 /////////////////////////
    //画折线
    NSMutableArray *points = [NSMutableArray array];
    CGSize textSize = [@"0.1" sizeWithAttributes:self.attr];
    for (NSInteger i = 0; i < self.valueArray.count; i++) {
        CGFloat chartHeight = self.frame.size.height - xAxisTextGap - textSize.height - topMargin - 1;
        NSNumber *drawValue = self.valueArray[i];
        CGPoint drawPoint = CGPointMake((i) * pointGap + self.edgeWidth/2,
                                        chartHeight + topMargin + 0.5 - (drawValue.floatValue - self.yMin)/(self.yMax - self.yMin) * chartHeight);
        [points addObject:[NSValue valueWithCGPoint:drawPoint]];
    }
    self.arrPoints = [points copy];
    UIBezierPath *path = [self getPathWithPoints:self.arrPoints];
    
    //设置画笔颜色
    [self.color set];
    path.lineWidth = 1.5;
    path.miterLimit = 1;
    [path stroke];
}

- (UIBezierPath *)getPathWithPoints:(NSArray <NSValue *> *)points
{
    UIBezierPath *path = [UIBezierPath bezierPath]; // 贝塞尔曲线
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound;//两条线连结点的样式
    for (int i = 0; i < points.count; i ++) {
        if (i) {
            [path addLineToPoint:[points[i] CGPointValue]];   // 添加路径
        }
        else{
            [path moveToPoint:[points[i] CGPointValue]];   // 路径起点
        }
    }
    return path;
}

- (CGPoint)getPointForIndex:(int)index
{
    if (index >= self.arrPoints.count) {
        index = 0;
    }
    if (!self.arrPoints.count) {
        return CGPointZero;
    }
    return [self.arrPoints[index] CGPointValue];
}

@end
