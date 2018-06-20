//
//  PointView.m
//  HCLineChart
//
//  Created by 韩冲 on 2018/6/1.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "PointView.h"

@implementation PointView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        CAShapeLayer *layer1 = [CAShapeLayer layer];
        CAShapeLayer *layer2 = [CAShapeLayer layer];
        layer1.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width) cornerRadius:frame.size.width/2].CGPath;
        layer2.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.bounds.size.width/4, self.bounds.size.width/4, self.bounds.size.width/2, self.bounds.size.width/2) cornerRadius:frame.size.width/4].CGPath;
        layer1.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4].CGColor;
        layer2.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
        [self.layer addSublayer:layer1];
        [self.layer addSublayer:layer2];
        
    }
    return self;
}

- (void)setPosition:(CGPoint)position
{
    CGRect rect = self.frame;
    rect.origin = position;
    self.frame = rect;
}

@end
