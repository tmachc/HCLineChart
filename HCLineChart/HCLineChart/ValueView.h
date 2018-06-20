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
@property (assign, nonatomic) CGFloat pointGap;//点之间的距离

- (instancetype)initWithFrame:(CGRect)frame valueArray:(NSArray*)valueArray pointGap:(CGFloat)pointGap yMax:(CGFloat)yMax yMin:(CGFloat)yMin;
- (CGPoint)getPointForIndex:(int)index;
- (void)resetBgColor;

@end
