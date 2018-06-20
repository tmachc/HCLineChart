//
//  ChartTitleView.m
//  F2Pool
//
//  Created by 韩冲 on 2018/6/11.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "ChartTitleView.h"
#import "PointView.h"

@interface ChartTitleView ()

@property (nonatomic, strong) PointView *pointView;
@property (nonatomic, strong) UILabel *labChartTitle;
@property (nonatomic, strong) UILabel *labChartUnit;

@end

@implementation ChartTitleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        WS(ws);
        self.pointView = ({
            PointView *point = [[PointView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
            point;
        });
        self.labChartTitle = ({
            UILabel *lab = [[UILabel alloc] init];
            lab.font = [UIFont systemFontOfSize:12];
            lab.textColor = [UIColor whiteColor];
            lab.textAlignment = NSTextAlignmentRight;
            lab;
        });
        self.labChartUnit = ({
            UILabel *lab = [[UILabel alloc] init];
            lab.font = [UIFont systemFontOfSize:12];
            lab.textColor = [UIColor whiteColor];
            lab.textAlignment = NSTextAlignmentLeft;
            lab;
        });
        [self addSubview:self.pointView];
        [self addSubview:self.labChartTitle];
        [self addSubview:self.labChartUnit];
        
        [self.labChartTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-12);
            make.width.mas_equalTo(WINDOW_WIDTH - 30 - 80);
            make.height.mas_equalTo(ws);
            make.top.mas_equalTo(0);
        }];
        [self.labChartUnit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(ws.labChartTitle);
            make.top.mas_equalTo(ws.labChartTitle);
        }];
        [self.pointView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(ws.labChartTitle);
            make.right.mas_equalTo(ws.labChartTitle.mas_left);
            make.height.width.mas_equalTo(8);
        }];
    }
    return self;
}

- (void)setCoinName:(NSString *)coin unit:(NSString *)unit
{
    self.labChartTitle.text = [NSString stringWithFormat:@"%@过去24小时算力", coin];
    CGSize textSize = [self.labChartTitle.text sizeWithAttributes:@{NSFontAttributeName: self.labChartTitle.font}];
    [self.labChartTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(textSize.width + 5);
    }];
    self.labChartUnit.text = unit;
}

@end
