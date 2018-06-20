//
//  YAxisView.h
//  HCLineChart
//
//  Created by 韩冲 on 2018/5/30.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "AxisView.h"

@interface YAxisView : AxisView

@property (assign, nonatomic) CGFloat yMax;
@property (assign, nonatomic) CGFloat yMin;

- (instancetype)initWithFrame:(CGRect)frame yMax:(CGFloat)yMax yMin:(CGFloat)yMin;

@end
