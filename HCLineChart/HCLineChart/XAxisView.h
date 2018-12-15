//
//  XAxisView.h
//  HCLineChart
//
//  Created by 韩冲 on 2018/5/30.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "AxisView.h"

@interface XAxisView : AxisView

@property (strong, nonatomic) NSArray *xTitleArray;
@property (strong, nonatomic) NSArray *yValueArray;
@property (assign, nonatomic) CGFloat yMax;
@property (assign, nonatomic) CGFloat yMin;
@property (nonatomic, assign) CGFloat edgeWidth;

- (instancetype)initWithFrame:(CGRect)frame xTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray edgeWidth:(CGFloat)edgeWidth yMax:(CGFloat)yMax yMin:(CGFloat)yMin;

@end
