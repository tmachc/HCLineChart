//
//  XScrollView.h
//  HCLineChart
//
//  Created by 韩冲 on 2018/6/1.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XscrViewDelegate <NSObject>

- (void)touchPoint:(CGPoint)point;

@end

@interface XScrollView : UIScrollView

@property (weak) id <XscrViewDelegate> xdelegate;

@end
