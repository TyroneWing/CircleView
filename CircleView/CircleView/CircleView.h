//
//  CircleView.h
//  CircleView
//
//  Created by yi on 15/12/16.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *cirleColor;
@property (nonatomic, strong) UIFont *percentFont;
@property (nonatomic, assign) CGFloat animationTime;

//加入圆弧layer
-(void)makeCircle:(NSInteger)percent;

@end
