//
//  ValueView.m
//  HCLineChart
//
//  Created by 韩冲 on 2018/6/1.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "ValueView.h"

@interface ValueView ()

@property (nonatomic, strong) NSArray *arrPoints;

@end

@implementation ValueView

- (instancetype)initWithFrame:(CGRect)frame valueArray:(NSArray*)valueArray pointGap:(CGFloat)pointGap yMax:(CGFloat)yMax yMin:(CGFloat)yMin
{
    self = [super initWithFrame:frame];
    if (self) {
        self.yMax = yMax;
        self.yMin = yMin;
        self.valueArray = valueArray;
        self.pointGap = pointGap;
        self.backgroundColor = [UIColor clearColor];
        [self resetBgColor];
    }
    return self;
}

- (void)resetBgColor
{
    self.layer.sublayers = @[];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7].CGColor, (__bridge id)[UIColor colorWithRed:1 green:1 blue:1 alpha:0].CGColor];
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.frame = self.bounds;
    [self.layer addSublayer:gradientLayer];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    /////////////////////// 根据数据源画折线 /////////////////////////
    if (self.valueArray && self.valueArray.count > 0) {
        //画折线
        NSMutableArray *points = [NSMutableArray array];
        CGSize textSize = [@"0.1" sizeWithAttributes:self.attr];
        CGFloat allLabelHeight = self.frame.size.height - xAxisTextGap - textSize.height;
        for (NSInteger i = 0; i < self.valueArray.count; i++) {
            CGFloat chartHeight = self.frame.size.height - xAxisTextGap - textSize.height - topMargin - 1;
            NSNumber *drawValue = self.valueArray[i];
            CGPoint drawPoint = CGPointMake((i) * self.pointGap,
                                            chartHeight + topMargin + 0.5 - (drawValue.floatValue - self.yMin)/(self.yMax - self.yMin) * chartHeight);
            [points addObject:[NSValue valueWithCGPoint:drawPoint]];
        }
        self.arrPoints = [points copy];
        UIBezierPath *path = [self getPathWithPoints:self.arrPoints];
        UIBezierPath *linePath = [path copy];
        
        [path addLineToPoint:CGPointMake(self.frame.size.width - lastSpace, allLabelHeight + 0.5)];  // 添加路径
        [path addLineToPoint:CGPointMake(0, allLabelHeight + 0.5)];    // 添加路径
        [path closePath];   // 封闭路径
        // ShapeLayer
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = path.CGPath;
        // 将CAShapeLayer设置为渐变层的mask
        self.layer.mask = maskLayer;
        
        //设置画笔颜色
        [[UIColor whiteColor] set];
        linePath.lineWidth = 3;
        linePath.miterLimit = 2;
        [linePath stroke];
    }
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
    return [self.arrPoints[index] CGPointValue];
}

@end
