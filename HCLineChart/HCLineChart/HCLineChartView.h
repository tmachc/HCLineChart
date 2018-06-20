//
//  HCLineChartView.h
//  HCLineChart
//
//  Created by 韩冲 on 2018/5/30.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCLineChartView : UIView

- (instancetype)initWithFrame:(CGRect)frame xTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray;
- (void)startAnimate;
- (void)resetxTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray;

@end

