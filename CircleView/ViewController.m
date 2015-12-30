//
//  ViewController.m
//  CircleView
//
//  Created by yi on 15/12/16.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"

@interface ViewController ()
{
    CircleView *circleView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    circleView = [[CircleView alloc] initWithFrame:CGRectMake(100, 100, 120, 120)];
//    circleView.lineWidth = 25;
//    circleView.cirleColor = [UIColor orangeColor];
//    circleView.percentFont = [UIFont boldSystemFontOfSize:20];
//    circleView.animationTime = 1;
    [circleView makeCircle:28];
    [self.view addSubview:circleView];
    
    
    UIButton *_mdsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mdsBtn.frame = CGRectMake(50, 350, 100, 30);
    [_mdsBtn setTitle:@"change" forState:UIControlStateNormal];
    _mdsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_mdsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_mdsBtn addTarget:self action:@selector(mdsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_mdsBtn];
}

- (void)mdsBtnClick:(UIButton *)btn
{
    int per = arc4random()%100;
    [circleView makeCircle:per];
    [btn setTitle:[NSString stringWithFormat:@"%d",per] forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
