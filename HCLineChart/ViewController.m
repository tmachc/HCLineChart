//
//  ViewController.m
//  HCLineChart
//
//  Created by 韩冲 on 2018/5/30.
//  Copyright © 2018年 f2pool. All rights reserved.
//

#import "ViewController.h"
#import "HCLineChartView.h"

@interface ViewController ()

@property (nonatomic, strong) HCLineChartView *hcLine;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:81.0f/255.0f green:93.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    
    NSMutableArray *xArray = [NSMutableArray array];
    NSMutableArray *yArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 51; i++) {
        
        [xArray addObject:[NSString stringWithFormat:@"%.1f",3+0.1*i]];
        [yArray addObject:[NSString stringWithFormat:@"%.2lf",(20.0+arc4random_uniform(50))]];
//        [yArray addObject:[NSString stringWithFormat:@"%.2lf",0.0+i * 2]];
        
    }
    
    self.hcLine = [[HCLineChartView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 300) xTitleArray:xArray yValueArray:yArray];
    [self.view addSubview:self.hcLine];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 600, 100, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"重置" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(reset:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.hcLine startAnimate];
}

- (IBAction)reset:(UIButton *)sender
{
    NSMutableArray *xArray = [NSMutableArray array];
    NSMutableArray *yArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 51; i++) {
        [xArray addObject:[NSString stringWithFormat:@"%.1f",3+0.1*i]];
        [yArray addObject:[NSString stringWithFormat:@"%.2lf",0.0+arc4random_uniform(50)]];
        //        [yArray addObject:[NSString stringWithFormat:@"%.2lf",0.0+i * 2]];
        
    }
    [_hcLine resetxTitleArray:xArray yValueArray:yArray];
}

@end
