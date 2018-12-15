//
//  CommonTool.h
//  F2Pool
//
//  Created by 韩冲 on 2018/5/14.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonTool : NSObject

/** 添加渐变色 */
+ (void)setBackgroundColors:(NSArray <UIColor *> *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint forView:(UIView *)view;

@end
