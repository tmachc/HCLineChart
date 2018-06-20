//
//  HCLineChartView.m
//  HCLineChart
//
//  Created by 韩冲 on 2018/5/30.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "HCLineChartView.h"
#import "XAxisView.h"
#import "YAxisView.h"
#import "ValueView.h"
#import "XScrollView.h"
#import "PointView.h"

@interface HCLineChartView () <XscrViewDelegate>

@property (strong, nonatomic) NSArray *xTitleArray;
@property (strong, nonatomic) NSArray *yValueArray;
@property (assign, nonatomic) CGFloat yMax;
@property (assign, nonatomic) CGFloat yMin;
@property (assign, nonatomic) CGFloat yAxisWidth;
@property (strong, nonatomic) PointView *pointView;
@property (strong, nonatomic) UILabel *labPoint;
@property (strong, nonatomic) YAxisView *yAxisView;
@property (strong, nonatomic) XAxisView *xAxisView;
@property (strong, nonatomic) ValueView *valueView;
@property (strong, nonatomic) UIView *animateView;
@property (strong, nonatomic) XScrollView *scrollView;
@property (assign, nonatomic) CGFloat pointGap;

@end

@implementation HCLineChartView

- (instancetype)initWithFrame:(CGRect)frame xTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _pointView = [[PointView alloc] initWithFrame:CGRectMake(100, 100, 12, 12)];
        _pointView.alpha = 0;
        _labPoint = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 18, 18)];
        _labPoint.backgroundColor = [UIColor whiteColor];
        _labPoint.textColor = [UIColor colorWithRed:53.0/255 green:116.0/255 blue:250.0/255 alpha:1];
        _labPoint.textAlignment = NSTextAlignmentCenter;
        _labPoint.font = [UIFont systemFontOfSize:_labPoint.frame.size.height/1.8];
        _labPoint.layer.cornerRadius = _labPoint.frame.size.height/2;
        _labPoint.clipsToBounds = true;
        _labPoint.alpha = 0;
        _xTitleArray = xTitleArray;
        _yValueArray = yValueArray;
        if (xTitleArray.count == 0 && yValueArray.count == 0) {
            _xTitleArray = @[@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @""];
            _yValueArray = @[@"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0"];
        }
        [self getYMaxYMin];
        _pointGap = 25;
        [self createYAxisView];
        [self createXAxisView];
        [self createValueView];
    }
    return self;
}

#pragma mark - setter

- (void)setYMax:(CGFloat)yMax
{
    _yMax = yMax;
    self.yAxisView.yMax = yMax;
    self.xAxisView.yMax = yMax;
    self.valueView.yMax = yMax;
}

- (void)setYMin:(CGFloat)yMin
{
    _yMin = yMin;
    self.yAxisView.yMin = yMin;
    self.xAxisView.yMin = yMin;
    self.valueView.yMin = yMin;
}

- (void)setXTitleArray:(NSArray *)xTitleArray
{
    _xTitleArray = xTitleArray;
    self.xAxisView.xTitleArray = xTitleArray;
}

- (void)setYValueArray:(NSArray *)yValueArray
{
    _yValueArray = yValueArray;
    self.xAxisView.yValueArray = yValueArray;
    self.valueView.valueArray = yValueArray;
}

#pragma mark - function

- (void)getYMaxYMin
{
    CGFloat maxValue = [[_yValueArray valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat step = maxValue/9.5;
    float trueStep;
    float multiple = 1.0;
    
    if (step == 0) {
        step = 0.1;
    }
    if (step < 1) {
        do {
            step = step * 10;
            multiple = multiple / 10;
        } while (step < 1);
    }
    else {
        if (step > 1000) {
            while (step > 100) {
                step = step / 10;
                multiple = multiple * 10;
            }
        }
        else {
            while (step > 10) {
                step = step / 10;
                multiple = multiple * 10;
            }
        }
    }
    int intStep = (int)step;
    if (step > intStep) {
        intStep ++;
    }
    trueStep = intStep * multiple;
    _yMax = trueStep * 10;
    _yMin = 0;
    CGSize labelSize;
    if (_yMax > 1) {
        if (_yMax/10 > (int)(_yMax/10)) {
            labelSize = [[NSString stringWithFormat:@"%.1f", _yMax] sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:8],NSForegroundColorAttributeName:kChartTextColor}];
        }
        else {
            labelSize = [[NSString stringWithFormat:@"%d", (int)_yMax] sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:8],NSForegroundColorAttributeName:kChartTextColor}];
        }
    }
    else {
        labelSize = [[NSString stringWithFormat:@"%.1f", _yMax] sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:8],NSForegroundColorAttributeName:kChartTextColor}];
    }
    _yAxisWidth = labelSize.width + 12 + 6;
}

- (void)resetxTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray
{
    self.xTitleArray = xTitleArray;
    self.yValueArray = yValueArray;
    [self getYMaxYMin];
    self.yMax = _yMax;
    self.yMin = _yMin;
    [self.scrollView setContentOffset:CGPointZero animated:false];
    self.labPoint.alpha = 0;
    self.pointView.alpha = 0;
    
    self.yAxisView.frame = CGRectMake(0, 0, self.yAxisWidth, self.frame.size.height);
    self.scrollView.frame = CGRectMake(self.yAxisWidth, 0, self.frame.size.width-self.yAxisWidth, self.frame.size.height);
    self.xAxisView.frame = CGRectMake(0, 0, (self.xTitleArray.count - 1) * self.pointGap + lastSpace, self.frame.size.height);
    self.valueView.frame = self.xAxisView.frame;
    self.scrollView.contentSize = self.xAxisView.frame.size;
    [self.valueView resetBgColor];
    
    [self.yAxisView setNeedsDisplay];
    [self.xAxisView setNeedsDisplay];
    [self.valueView setNeedsDisplay];
    self.animateView.frame = CGRectMake(0, 0, 0, self.frame.size.height);
    [self startAnimate];
}

- (void)createYAxisView
{
    self.yAxisView = [[YAxisView alloc] initWithFrame:CGRectMake(0, 0, self.yAxisWidth, self.frame.size.height) yMax:self.yMax yMin:self.yMin];
    [self addSubview:self.yAxisView];
}

- (void)createXAxisView
{
    _scrollView = [[XScrollView alloc] initWithFrame:CGRectMake(self.yAxisWidth, 0, self.frame.size.width-self.yAxisWidth, self.frame.size.height)];
    _scrollView.xdelegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
    
    self.xAxisView = [[XAxisView alloc] initWithFrame:CGRectMake(0, 0, (self.xTitleArray.count - 1) * self.pointGap + lastSpace, self.frame.size.height) xTitleArray:self.xTitleArray yValueArray:self.yValueArray pointGap:self.pointGap yMax:self.yMax yMin:self.yMin];
    
    [_scrollView addSubview:self.xAxisView];
    
    _scrollView.contentSize = self.xAxisView.frame.size;
    
}

- (void)createValueView
{
    self.animateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
    self.animateView.clipsToBounds = true;
    self.valueView = [[ValueView alloc] initWithFrame:self.xAxisView.frame valueArray:self.yValueArray pointGap:self.pointGap yMax:self.yMax yMin:self.yMin];
    [self.animateView addSubview:self.valueView];
    [_scrollView addSubview:self.animateView];
    
    [_scrollView addSubview:_pointView];
    [_scrollView addSubview:_labPoint];
}

- (void)startAnimate
{
    [UIView animateWithDuration:1.8
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.animateView.frame = CGRectMake(0, 0, (self.xTitleArray.count - 1) * self.pointGap + lastSpace, self.frame.size.height);
                     } completion:nil];
}

#pragma mark - delegate

- (void)touchPoint:(CGPoint)point
{
    float findex = point.x / self.pointGap;
    int index;
    if (findex - (int)findex >= 0.5) {
        index = (int)findex + 1;
    }
    else {
        index = (int)findex;
    }
    CGFloat width = self.pointView.bounds.size.width;
    CGPoint pointValue = [self.valueView getPointForIndex:index];
    [self.pointView setPosition:CGPointMake(pointValue.x - width/2, pointValue.y - width/2 + 1)];
    
    self.labPoint.text = self.yValueArray[index];
    CGSize size = [self.yValueArray[index] sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:self.labPoint.frame.size.height/1.8],NSForegroundColorAttributeName:kChartTextColor}];
    CGPoint pointLab = CGPointMake(pointValue.x + 6, pointValue.y - 25);
    CGRect rect = self.labPoint.frame;
    rect.origin = pointLab;
    rect.size.width = size.width + rect.size.height;
    // 右边超出 放左边
    if (CGRectGetMaxX(rect) > self.xAxisView.frame.size.width) {
        pointLab.x = pointValue.x - 6 - rect.size.width;
        rect.origin = pointLab;
    }
    // 上边超出 放下边
    if (CGRectGetMinY(rect) < 0) {
        pointLab.y = pointValue.y + 6;
        rect.origin = pointLab;
    }
    self.labPoint.frame = rect;
    self.pointView.alpha = 0;
    self.labPoint.alpha = 0;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.pointView.alpha = 1;
//        self.labPoint.alpha = 1;
//    }];
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
            self.pointView.alpha = 0.1;
            self.labPoint.alpha = 0.1;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.6 animations:^{
            self.pointView.alpha = 0.9;
            self.labPoint.alpha = 0.9;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            self.pointView.alpha = 1;
            self.labPoint.alpha = 1;
        }];
    } completion:^(BOOL finished) {

    }];
}

- (void)dealloc
{
    NSLog(@"%@ dealloc", [self class]);
}

@end
