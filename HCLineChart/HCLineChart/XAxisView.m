//
//  XAxisView.m
//  HCLineChart
//
//  Created by 韩冲 on 2018/5/30.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "XAxisView.h"

@interface XAxisView ()

/**
 *  记录坐标轴的第一个frame
 */
@property (assign, nonatomic) CGRect firstFrame;

@end

@implementation XAxisView

- (instancetype)initWithFrame:(CGRect)frame xTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray edgeWidth:(CGFloat)edgeWidth yMax:(CGFloat)yMax yMin:(CGFloat)yMin
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.xTitleArray = xTitleArray;
        self.yValueArray = yValueArray;
        self.yMax = yMax;
        self.yMin = yMin;
        self.edgeWidth = edgeWidth;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.xTitleArray.count == 0) {
        return;
    }
    // 分为4个格  有5条分割线
    int noUseNum = self.xTitleArray.count % 4;
    int oneCaseNum = (int)(self.xTitleArray.count / 4);
    CGFloat oneCaseWidth = (self.frame.size.width - self.edgeWidth) / 4;
    if (noUseNum) {
        noUseNum --;
    }
    else {
        noUseNum = 3;
        oneCaseNum --;
    }
    /*************** X轴文字 ***************/
    // 添加坐标轴Label
    for (int i = 0; i < self.xTitleArray.count - noUseNum; i++) {
        NSString *title = self.xTitleArray[i];
        
        [[UIColor whiteColor] set];
        CGSize labelSize = [title sizeWithAttributes:self.attr];
        CGRect titleRect = CGRectMake((int)(i / oneCaseNum) * oneCaseWidth - labelSize.width/2 + self.edgeWidth/2,
                                      self.frame.size.height - labelSize.height,
                                      labelSize.width,
                                      labelSize.height);
        
        if (i == 0) {
            self.firstFrame = CGRectZero;
        }
        if (CGRectGetMinX(titleRect) < 0) {
            titleRect.origin.x = 0;
        }
        // 如果Label的文字有重叠，那么不绘制
        CGFloat maxX = CGRectGetMaxX(self.firstFrame);
        if (i % oneCaseNum || maxX > titleRect.origin.x) {
            //不绘制
        }
        else {
            if (CGRectGetMaxX(titleRect) > rect.size.width) {
                titleRect.origin.x = rect.size.width - titleRect.size.width;
            }
            [title drawInRect:titleRect withAttributes:self.attr];
            self.firstFrame = titleRect;
            //画垂直X轴的竖线
            [self drawLineWithStartPoint:CGPointMake((int)(i / oneCaseNum) * oneCaseWidth + self.edgeWidth/2, xAxisTextGap)
                                endPoint:CGPointMake((int)(i / oneCaseNum) * oneCaseWidth + self.edgeWidth/2, self.frame.size.height - labelSize.height - xAxisTextGap)
                               lineColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]
                               lineWidth:0.5];
        }
        
    }
    
    CGSize textSize = [@"0.1" sizeWithAttributes:self.attr];
    CGFloat allLabelHeight = self.frame.size.height - xAxisTextGap - textSize.height;
    /*************** 画原点上的x轴 *********************/
    [self drawLineWithStartPoint:CGPointMake(0, allLabelHeight)
                        endPoint:CGPointMake(self.frame.size.width, allLabelHeight)
                       lineColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]
                       lineWidth:0.5];
    
    /*************** 画横向分割线 **********************/
    CGFloat separateMargin = (allLabelHeight - 1 - numberOfYAxisElements * 1 - topMargin) / numberOfYAxisElements;
    for (int i = 0; i < numberOfYAxisElements; i ++) {
        [self drawLineWithStartPoint:CGPointMake(0, allLabelHeight - 1 - (i + 1) * (separateMargin + 1))
                            endPoint:CGPointMake(self.frame.size.width, allLabelHeight - 1 - (i + 1) * (separateMargin + 1))
                           lineColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1 * (numberOfYAxisElements - i) * 0.5]
                           lineWidth:0.5];
    }
}

@end
