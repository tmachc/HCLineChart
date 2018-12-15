//
//  LineView.h
//  F2Pool
//
//  Created by 韩冲 on 2018/8/3.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "AxisView.h"

@interface LineView : AxisView

@property (assign, nonatomic) CGFloat yMax;
@property (assign, nonatomic) CGFloat yMin;
@property (strong, nonatomic) NSArray *valueArray;
@property (nonatomic, assign) CGFloat edgeWidth;

- (instancetype)initWithFrame:(CGRect)frame valueArray:(NSArray*)valueArray edgeWidth:(CGFloat)edgeWidth yMax:(CGFloat)yMax yMin:(CGFloat)yMin color:(UIColor *)color;
- (CGPoint)getPointForIndex:(int)index;

@end
