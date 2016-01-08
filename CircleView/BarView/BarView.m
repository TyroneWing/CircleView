//
//  BarView.m
//  BarView
//
//  Created by yi on 16/1/8.
//  Copyright © 2016年 yi. All rights reserved.
//

#import "BarView.h"

@interface BarView ()
{
    CABasicAnimation *pathAnimation;
}
@property (nonatomic,strong) CAShapeLayer *barLayer;
@end

@implementation BarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _barLayer = [CAShapeLayer layer];
        _barLayer.lineCap = kCALineCapSquare;
        _barLayer.fillColor   = [[UIColor whiteColor] CGColor];
        _barLayer.lineWidth   = self.frame.size.width;
        _barLayer.strokeEnd   = 0.0;
        self.clipsToBounds = YES;
        [self.layer addSublayer:_barLayer];
        self.layer.cornerRadius = 2.0;
        
        [self drawAnimation];
    }
    return self;
}

- (void)drawAnimation
{
    pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
}

-(void)setPercent:(float)percent
{
    if (percent==0)
        return;
    _percent = percent;
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    [progressline moveToPoint:CGPointMake(self.frame.size.width/2.0, self.frame.size.height+self.frame.size.width/2.0)];
    [progressline addLineToPoint:CGPointMake(self.frame.size.width/2.0, (1 - percent) * self.frame.size.height+self.frame.size.width/2.0)];
    [progressline setLineCapStyle:kCGLineCapSquare];
    _barLayer.path = progressline.CGPath;
    if (_barColor) {
        _barLayer.strokeColor = [_barColor CGColor];
    } else {
        _barLayer.strokeColor = [[UIColor orangeColor] CGColor];
    }
    [_barLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    _barLayer.strokeEnd = 2.0;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
