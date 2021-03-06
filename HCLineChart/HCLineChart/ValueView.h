//
//  ValueView.h
//  HCLineChart
//
//  Created by 韩冲 on 2018/6/1.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "AxisView.h"

@interface ValueView : AxisView

@property (assign, nonatomic) CGFloat yMax;
@property (assign, nonatomic) CGFloat yMin;
@property (strong, nonatomic) NSArray *valueArray;
@property (nonatomic, assign) CGFloat edgeWidth;

- (instancetype)initWithFrame:(CGRect)frame valueArray:(NSArray*)valueArray edgeWidth:(CGFloat)edgeWidth yMax:(CGFloat)yMax yMin:(CGFloat)yMin color:(UIColor *)color;
- (CGPoint)getPointForIndex:(int)index;
- (void)resetBgColor;

@end
