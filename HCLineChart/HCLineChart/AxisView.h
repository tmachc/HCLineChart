//
//  AxisView.h
//  HCLineChart
//
//  Created by 韩冲 on 2018/5/30.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import <UIKit/UIKit.h>

#define lastSpace 5
#define topMargin 5   // 为顶部留出的空白
#define xAxisTextGap 5 //x轴文字与坐标轴间隙
#define numberOfYAxisElements 10 // y轴分为几段
#define kChartLineColor         [UIColor whiteColor]
#define kChartTextColor         [UIColor whiteColor]
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface AxisView : UIView

@property (nonatomic, strong) NSDictionary *attr;

- (void)drawLineWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor lineWidth:(CGFloat)width;
- (BOOL)isPureFloat:(CGFloat)num;

@end
