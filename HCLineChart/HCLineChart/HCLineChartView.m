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
#import "PointView.h"
#import "LineView.h"

@interface HCLineChartView ()

@property (strong, nonatomic) NSArray *xTitleArray;
@property (strong, nonatomic) NSArray *yValueArray;
@property (assign, nonatomic) CGFloat yMax;
@property (assign, nonatomic) CGFloat yMin;
@property (assign, nonatomic) CGFloat yAxisWidth;
@property (strong, nonatomic) YAxisView *yAxisView;
@property (strong, nonatomic) XAxisView *xAxisView;
@property (strong, nonatomic) ValueView *valueView;
@property (strong, nonatomic) LineView *lineView;
@property (strong, nonatomic) UIView *animateView;
@property (assign, nonatomic) CGFloat edgeWidth; // 空白区域总长
@property (assign, nonatomic) CGFloat pointGap;  // 点之间的距离
@property (strong, nonatomic) UIColor *color;    // 线和填充区的颜色
/* 选中时候显示的view */
@property (strong, nonatomic) PointView *pointView;
@property (strong, nonatomic) UIView *viewLabPoint;
@property (strong, nonatomic) UILabel *labPoint;
@property (strong, nonatomic) UILabel *labUnit;
@property (strong, nonatomic) UILabel *labTime;
@property (strong, nonatomic) UIView *viewLine;

@end

@implementation HCLineChartView

- (instancetype)initWithFrame:(CGRect)frame xTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray
{
    self = [super initWithFrame:frame];
    if (self) {
        WS(ws);
        self.backgroundColor = [UIColor clearColor];
        _color = [UIColor whiteColor];
        _pointView = [[PointView alloc] initWithFrame:CGRectMake(100, 100, 12, 12)];
        _pointView.alpha = 0;
        _viewLabPoint = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 30, 32)];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.cornerRadius = 4;
            view.alpha = 0;
            view.clipsToBounds = true;
            view;
        });
        _labPoint = ({
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 18, 18)];
            lab.textColor = BlueColor;
            lab.textAlignment = NSTextAlignmentLeft;
            lab.font = [UIFont systemFontOfSize:11];
            lab.clipsToBounds = true;
            lab;
        });
        _labUnit = ({
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 3, 14, 14)];
            lab.textColor = BlueColor;
            lab.textAlignment = NSTextAlignmentRight;
            lab.font = [UIFont systemFontOfSize:8];
            lab.clipsToBounds = true;
            lab;
        });
        _labTime = ({
            UILabel *lab = [[UILabel alloc] init];
            lab.textColor = BlueColor;
            lab.textAlignment = NSTextAlignmentRight;
            lab.font = [UIFont systemFontOfSize:9];
            lab.clipsToBounds = true;
            lab;
        });
        _viewLine = ({
            UIView *view = [[UIView alloc] init];
            view.clipsToBounds = true;
            view.alpha = 0;
            view;
        });
        [_viewLabPoint addSubview:_labPoint];
        [_viewLabPoint addSubview:_labUnit];
        [_viewLabPoint addSubview:_labTime];
        [_labPoint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.width.top.mas_equalTo(ws.viewLabPoint);
            make.height.mas_equalTo(20);
        }];
        [_labUnit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.top.mas_equalTo(4);
            make.width.mas_equalTo(ws.viewLabPoint);
            make.height.mas_equalTo(14);
        }];
        [_labTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(ws.viewLabPoint).mas_offset(-2);
            make.width.mas_equalTo(ws.viewLabPoint);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(12);
        }];
        _xTitleArray = xTitleArray;
        _yValueArray = yValueArray;
        if (xTitleArray.count == 0 || yValueArray.count == 0) {
            _xTitleArray = @[@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @""];
            _yValueArray = @[@"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0"];
        }
        // 添加坐标轴Label 取前4x + 1个
        int noUseNum = _xTitleArray.count % 4;
        if (noUseNum) {
            noUseNum --;
        }
        else {
            noUseNum = 3;
        }
        _xTitleArray = [_xTitleArray subarrayWithRange:NSMakeRange(noUseNum, _xTitleArray.count - noUseNum)];
        noUseNum = _yValueArray.count % 4;
        if (noUseNum) {
            noUseNum --;
        }
        else {
            noUseNum = 3;
        }
        _yValueArray = [_yValueArray subarrayWithRange:NSMakeRange(noUseNum, _yValueArray.count - noUseNum)];
        _edgeWidth = 14;
        [self getYMaxYMin];
        [self createYAxisView];
        [self createXAxisView];
        [self createValueView];
        _pointGap = self.xAxisView.frame.size.width / self.yValueArray.count;
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
    self.lineView.yMax = yMax;
}

- (void)setYMin:(CGFloat)yMin
{
    _yMin = yMin;
    self.yAxisView.yMin = yMin;
    self.xAxisView.yMin = yMin;
    self.valueView.yMin = yMin;
    self.lineView.yMin = yMin;
}

- (void)setXTitleArray:(NSArray *)xTitleArray
{
    _xTitleArray = xTitleArray;
    // 添加坐标轴Label 取前4x + 1个
    int noUseNum = xTitleArray.count % 4;
    if (noUseNum) {
        noUseNum --;
    }
    else {
        noUseNum = 3;
    }
    _xTitleArray = [_xTitleArray subarrayWithRange:NSMakeRange(noUseNum, xTitleArray.count - noUseNum)];
    self.xAxisView.xTitleArray = _xTitleArray;
}

- (void)setYValueArray:(NSArray *)yValueArray
{
    _yValueArray = yValueArray;
    // 添加坐标轴Label 取前4x + 1个
    int noUseNum = yValueArray.count % 4;
    if (noUseNum) {
        noUseNum --;
    }
    else {
        noUseNum = 3;
    }
    _yValueArray = [_yValueArray subarrayWithRange:NSMakeRange(noUseNum, yValueArray.count - noUseNum)];
    self.xAxisView.yValueArray = _yValueArray;
    self.valueView.valueArray = _yValueArray;
    self.lineView.valueArray = _yValueArray;
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
    if (step < 1.5 && step > 1.0) {
        // intStep = 2;
        trueStep = 1.5 * multiple;
    }
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

- (void)resetxTitleArray:(NSArray *)xTitleArray yValueArray:(NSArray *)yValueArray unit:(NSString *)unit
{
    if (xTitleArray.count == 0 || yValueArray.count == 0) {
        xTitleArray = @[@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @""];
        yValueArray = @[@"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0"];
    }
    self.xTitleArray = xTitleArray;
    self.yValueArray = yValueArray;
    [self getYMaxYMin];
    self.yMax = _yMax;
    self.yMin = _yMin;
    self.viewLabPoint.alpha = 0;
    self.labUnit.text = unit;
    self.pointView.alpha = 0;
    self.viewLine.alpha = 0;
    self.viewLabPoint.alpha = 0;
    
    self.yAxisView.frame = CGRectMake(0, 0, self.yAxisWidth, self.frame.size.height);
    self.xAxisView.frame = CGRectMake(self.yAxisWidth, 0, self.frame.size.width - self.yAxisWidth - lastSpace, self.frame.size.height);
    _pointGap = self.xAxisView.frame.size.width / self.yValueArray.count;
    self.valueView.frame = self.xAxisView.frame;
    self.lineView.frame = self.xAxisView.frame;
    [self.valueView resetBgColor];
    
    [self.yAxisView setNeedsDisplay];
    [self.xAxisView setNeedsDisplay];
    [self.valueView setNeedsDisplay];
    [self.lineView setNeedsDisplay];
    [self startAnimate];
}

- (void)createYAxisView
{
    self.yAxisView = [[YAxisView alloc] initWithFrame:CGRectMake(0, 0, self.yAxisWidth, self.frame.size.height) yMax:self.yMax yMin:self.yMin];
    [self addSubview:self.yAxisView];
}

- (void)createXAxisView
{
    self.xAxisView = [[XAxisView alloc] initWithFrame:CGRectMake(self.yAxisWidth, 0, self.frame.size.width - self.yAxisWidth - lastSpace, self.frame.size.height) xTitleArray:self.xTitleArray yValueArray:self.yValueArray edgeWidth:self.edgeWidth yMax:self.yMax yMin:self.yMin];
    [self addSubview:self.xAxisView];
}

- (void)createValueView
{
    self.animateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
    self.animateView.clipsToBounds = true;
    self.valueView = [[ValueView alloc] initWithFrame:self.xAxisView.frame valueArray:self.yValueArray edgeWidth:self.edgeWidth yMax:self.yMax yMin:self.yMin color:_color];
    self.lineView = [[LineView alloc] initWithFrame:self.xAxisView.frame valueArray:self.yValueArray edgeWidth:self.edgeWidth yMax:self.yMax yMin:self.yMin color:_color];
    [self.animateView addSubview:self.valueView];
    [self.animateView addSubview:self.lineView];
    [self addSubview:self.animateView];
    
    [self addSubview:_viewLine];
    [self addSubview:_pointView];
    [self addSubview:_viewLabPoint];
}

- (void)startAnimate
{
    self.animateView.frame = CGRectMake(0, 0, 0, self.frame.size.height);
    [UIView animateWithDuration:1.2
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.animateView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
                     } completion:nil];
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:self];
    [self touchPoint:point];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchEnd];
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:self];
    [self touchPoint:point];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchEnd];
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchEnd
{
    self.pointView.alpha = 0;
    self.viewLabPoint.alpha = 0;
    self.viewLine.alpha = 0;
}

- (void)touchPoint:(CGPoint)point
{
    self.pointView.alpha = 0;
    self.viewLabPoint.alpha = 0;
    self.viewLine.alpha = 0;
    if (point.x > self.frame.size.width - self.edgeWidth/2 - lastSpace) {
        point.x = self.frame.size.width - self.edgeWidth/2 - lastSpace;
    }
    if (point.x < self.yAxisWidth + self.edgeWidth/2) {
        point.x = self.yAxisWidth + self.edgeWidth/2;
    }
    float findex = (point.x - self.yAxisWidth - self.edgeWidth/2) / ((self.xAxisView.frame.size.width - self.edgeWidth) / (self.yValueArray.count - 1));
    int index = (int)findex;
    CGPoint pointLeft = [self.lineView getPointForIndex:index];
    CGPoint pointRight = [self.lineView getPointForIndex:index + 1];
    CGPoint pointValue;
    float xOffset = findex - (int)findex;
    float yOffset = xOffset * (pointRight.y - pointLeft.y);
    if (findex - (int)findex >= 0.5) {
        index ++;
        pointValue = pointRight;
    }
    else {
        pointValue = pointLeft;
    }
    // 数组越界判断
    if (index < 0 || index >= self.xTitleArray.count) {
        return;
    }
    CGFloat width = self.pointView.bounds.size.width;
    pointValue.x += self.yAxisWidth;
    [self.pointView setPosition:CGPointMake(point.x - width/2, pointLeft.y - width/2 + yOffset)];
    CGSize textSize = [@"0.1" sizeWithAttributes:self.xAxisView.attr];
    self.viewLine.frame = CGRectMake(self.pointView.frame.origin.x + self.pointView.frame.size.width/2 - 0.5,
                                     self.pointView.frame.origin.y + self.pointView.frame.size.height/2 - 0.5,
                                     1,
                                     self.valueView.frame.size.height - self.pointView.frame.origin.y - self.pointView.frame.size.height/2 + 0.5 - textSize.height - xAxisTextGap);
    [self.viewLine.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAGradientLayer class]]) {
            *stop = YES;
            [obj removeFromSuperlayer];
        }
    }];
    [CommonTool setBackgroundColors:@[[UIColor whiteColor], [[UIColor whiteColor] colorWithAlphaComponent:0]] startPoint:CGPointZero endPoint:CGPointMake(0, 1) forView:self.viewLine];
    self.labTime.text = self.xTitleArray[index];
    self.labPoint.text = [NSString stringWithFormat:@"%.1f", [self.yValueArray[index] floatValue]];
    // 计算框位置
    CGSize size = [self.labPoint.text sizeWithAttributes:@{NSFontAttributeName: self.labPoint.font}];
    CGSize size1 = [self.labUnit.text sizeWithAttributes:@{NSFontAttributeName: self.labUnit.font}];
    CGPoint pointLab = CGPointMake(point.x + 9, self.valueView.frame.origin.y + self.valueView.frame.size.height * 0.05);
    CGRect rect = self.viewLabPoint.frame;
    rect.origin = pointLab;
    rect.size.width = size.width + 3 + size1.width + 10;
    CGSize size2 = [self.labTime.text sizeWithAttributes:@{NSFontAttributeName: self.labTime.font}];
    if (rect.size.width - 10 < size2.width) {
        rect.size.width = size2.width + 10;
    }
    // 右边超出 放左边
    if (CGRectGetMaxX(rect) > (self.xAxisView.frame.size.width + self.yAxisWidth)) {
        pointLab.x = point.x - 9 - rect.size.width;
        rect.origin = pointLab;
    }
    self.viewLabPoint.frame = rect;
    self.pointView.alpha = 1;
    self.viewLabPoint.alpha = 1;
    self.viewLine.alpha = 1;
}

- (void)dealloc
{
    HCLog(@"%@ dealloc", [self class]);
}

@end
