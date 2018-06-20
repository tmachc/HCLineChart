//
//  UIScrollView+UITouch.m
//  HCLineChart
//
//  Created by 韩冲 on 2018/6/1.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "UIScrollView+UITouch.h"

@implementation UIScrollView (UITouch)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 选其一即可
    [super touchesBegan:touches withEvent:event];
    //  [[self nextResponder] touchesBegan:touches withEvent:event];
}

@end
