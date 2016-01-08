//
//  CircleView.m
//  CircleView
//
//  Created by yi on 15/12/16.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "CircleView.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
#define DEGREES_DefaultStart(degrees)  ((M_PI * (degrees+270))/180)
@interface CircleView ()
{
    CABasicAnimation *pathAnimation;
}
@property (nonatomic, copy) NSString *percentText;
@property (nonatomic, assign) CGFloat endDegree;
@property (nonatomic, strong) CAShapeLayer *animtionLayer;
@property (nonatomic, strong) CAShapeLayer *edgeLayer;
@end

@implementation CircleView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupDefault];
        [self setupAnimation];
    }
    return self;
}
- (void)setupAnimation
{
    pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = self.animationTime;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0];
    pathAnimation.toValue = [NSNumber numberWithFloat:1];
    pathAnimation.autoreverses = NO;
}

- (void)setupDefault
{
    _percentText = @"0%";
    _lineWidth = 25;
    _cirleColor = RGBA(116, 201, 0, 1);
    _percentFont = [UIFont fontWithName:@"Arial"size:17];
    _animationTime = 1.5;
}

/**
 *  底层背景灰色圆
 */
-(void)drawBackCircle{

    UIBezierPath *edgePath = [UIBezierPath bezierPath];
    [edgePath addArcWithCenter:CGPointMake(self.frame.size.width*0.5, self.frame.size.height * 0.5) radius:self.frame.size.width * 0.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    if(!self.animtionLayer){
        self.edgeLayer = [CAShapeLayer layer];
        self.edgeLayer.path = edgePath.CGPath;
        self.edgeLayer.fillColor = self.backgroundColor.CGColor;
        self.edgeLayer.strokeColor = RGBA(240, 240, 240, 1).CGColor;
        self.edgeLayer.lineWidth = self.lineWidth;
        self.edgeLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.layer addSublayer:self.edgeLayer];
    }
}


/**
 *  设置百分比
 *
 *  @param percent 百分比
 */
-(void)makeCircle:(NSInteger)percent {
    
    self.endDegree = DEGREES_DefaultStart(percent/100.0 * 360);
    [self drawBackCircle];
    [self addPercentCircle];
    _percentText = [NSString stringWithFormat:@"%ld%%",percent];
    [self setNeedsDisplay];
}

/**
 *  画百分比圆弧
 */
-(void)addPercentCircle{
    
    UIBezierPath *animationPath = [UIBezierPath bezierPath];
    [animationPath addArcWithCenter:CGPointMake(self.frame.size.width*0.5, self.frame.size.height * 0.5) radius:self.frame.size.width * 0.5 startAngle:DEGREES_DefaultStart(0) endAngle:self.endDegree clockwise:YES];
    
    self.animtionLayer.path = animationPath.CGPath;
    if(!self.animtionLayer){
        self.animtionLayer = [CAShapeLayer layer];
        self.animtionLayer.fillColor = self.backgroundColor.CGColor;
        self.animtionLayer.strokeColor = self.cirleColor.CGColor;
        self.animtionLayer.lineWidth = self.lineWidth;
        self.animtionLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.layer addSublayer:self.animtionLayer];
    }
    self.animtionLayer.path = animationPath.CGPath;
    [self.animtionLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.backgroundColor = [UIColor clearColor];
    
    NSDictionary* attrs =@{NSForegroundColorAttributeName:self.cirleColor,
                           NSFontAttributeName:self.percentFont};
    CGSize percentTextSize = [_percentText boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    [_percentText drawAtPoint:CGPointMake((self.frame.size.width - percentTextSize.width)/2, (self.frame.size.height - percentTextSize.height)/2) withAttributes:attrs];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
