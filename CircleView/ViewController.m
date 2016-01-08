//
//  ViewController.m
//  CircleView
//
//  Created by yi on 15/12/16.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"
#import "BarView.h"

@interface ViewController ()
{
    CircleView *circleView;
    BarView *bar;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    circleView = [[CircleView alloc] initWithFrame:CGRectMake(160, 80, 120, 120)];
//    circleView.lineWidth = 25;
//    circleView.cirleColor = [UIColor orangeColor];
//    circleView.percentFont = [UIFont boldSystemFontOfSize:20];
//    circleView.animationTime = 1;
    [circleView makeCircle:28];
    [self.view addSubview:circleView];
    
    bar = [[BarView alloc] initWithFrame:CGRectMake(50, 60, 50, 150)];
    bar.percent = 0.28;
    bar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bar];
    
    UIButton *percentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    percentBtn.frame = CGRectMake(20, 20, 100, 30);
    [percentBtn setTitle:@"修改百分比" forState:UIControlStateNormal];
    percentBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [percentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [percentBtn addTarget:self action:@selector(percentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:percentBtn];
}

- (void)percentBtnClick:(UIButton *)btn
{
    int per = arc4random()%100;
    [circleView makeCircle:per];
    bar.percent = per/100.0;
    [btn setTitle:[NSString stringWithFormat:@"%d%%",per] forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
