//
//  HCLineChartView.h
//  HCLineChart
//
//  Created by 韩冲 on 2018/5/30.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

#ifndef __OPTIMIZE__
#define HCLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define HCLog(...)
#endif

#define WINDOW_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define WINDOW_WIDTH [UIScreen mainScreen].bounds.size.width
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]         //RGB进制颜色值
#define BlueColor    RGBCOLOR(53, 116, 250)

@interface HCLineChartView : UIView

- (instancetype)initWithFrame:(CGRect)frame xTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray;
- (void)startAnimate;
- (void)resetxTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray unit:(NSString *)unit;

@end

