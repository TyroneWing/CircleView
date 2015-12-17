//
//  CircleView.m
//  CircleView
//
//  Created by yi on 15/12/16.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "CircleView.h"

#define RGBA(r,g,b,a)      [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
#define pi 3.14159265359
#define DEGREES_DefaultStart(degrees)  ((pi * (degrees+270))/ 180) //默认270度为开始的位置
#define DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)         //转化为度

@interface CircleView ()
@property (nonatomic, assign) NSString *text;
@property (nonatomic, assign) CGFloat endDegree;
@property (nonatomic, strong) CAShapeLayer *animtionLayer;
@end

@implementation CircleView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self drawCircle];
        _text = @"0%";
    }
    return self;
}

//初始化
-(void)drawCircle{
    
    //边缘线
    UIBezierPath *edgePath = [UIBezierPath bezierPath];
    [edgePath addArcWithCenter:CGPointMake(self.frame.size.width*0.5, self.frame.size.height * 0.5) radius:self.frame.size.width * 0.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    CAShapeLayer *edgeLayer = [CAShapeLayer layer];
    edgeLayer.path = edgePath.CGPath;
    edgeLayer.fillColor = self.backgroundColor.CGColor;
    edgeLayer.strokeColor = RGBA(240, 240, 240, 1).CGColor;
    edgeLayer.lineWidth = 20;
    edgeLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.layer addSublayer:edgeLayer];
    
//    //边缘环
//    for (NSInteger i = 0; i < 10; i++) {
//        CGFloat startAngle =  DEGREES_DefaultStart(i * 36) ;
//        CGFloat endAngle = DEGREES_DefaultStart((i+1) * 36) - DEGREES_TO_RADIANS(1);
//        
//        UIBezierPath *ringPath = [UIBezierPath bezierPath];
//        [ringPath addArcWithCenter:CGPointMake(self.frame.size.width*0.5, self.frame.size.height * 0.5) radius:self.frame.size.width * 0.5 - (15*0.5 + 2*0.5) startAngle:startAngle endAngle:endAngle clockwise:YES];
//        
//        CAShapeLayer *ringLayer = [CAShapeLayer layer];
//        ringLayer.path = ringPath.CGPath;
//        ringLayer.fillColor = self.backgroundColor.CGColor;
//        ringLayer.strokeColor = RGBA(189, 189, 189, 1).CGColor;
//        ringLayer.lineWidth = 15;
//        ringLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//        [self.layer addSublayer:ringLayer];
//    }
    
}

//加入圆弧layer
-(void)makeCircle:(NSInteger)percent {
    
    self.endDegree = DEGREES_DefaultStart(percent/100.0 * 360);
    [self addCircle];
    _text = [NSString stringWithFormat:@"%ld%%",percent];
    [self setNeedsDisplay];
}

-(void)addCircle{
    
    UIBezierPath *animationPath = [UIBezierPath bezierPath];
    [animationPath addArcWithCenter:CGPointMake(self.frame.size.width*0.5, self.frame.size.height * 0.5) radius:self.frame.size.width * 0.5 startAngle:DEGREES_DefaultStart(0) endAngle:self.endDegree clockwise:YES];
    
    self.animtionLayer.path = animationPath.CGPath;
    if(!self.animtionLayer){
        self.animtionLayer = [CAShapeLayer layer];
        self.animtionLayer.fillColor = self.backgroundColor.CGColor;
        self.animtionLayer.strokeColor = RGBA(116, 201, 0, 1).CGColor;
        self.animtionLayer.lineWidth = 20;
        self.animtionLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.layer addSublayer:self.animtionLayer];
    }
    self.animtionLayer.path = animationPath.CGPath;
    
    //动画
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0];
    pathAnimation.toValue = [NSNumber numberWithFloat:1];
    pathAnimation.autoreverses = NO;
    [self.animtionLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.backgroundColor = [UIColor clearColor];
    UIColor *stringColor = RGBA(116, 201, 0, 1);//设置文本的颜色
    UIFont *textFont = [UIFont fontWithName:@"Arial"size:17];
    NSDictionary* attrs =@{NSForegroundColorAttributeName:stringColor,
                           NSFontAttributeName:textFont,
                           }; //在词典中加入文本的颜色 字体 大小
    CGSize textSize = [_text sizeWithFont:textFont constrainedToSize:self.frame.size lineBreakMode:NSLineBreakByWordWrapping];
    [_text drawAtPoint:CGPointMake((self.frame.size.width - textSize.width)/2, (self.frame.size.height - textSize.height)/2) withAttributes:attrs];
    
    //根据坐标点画在view上
    //    [attrString drawInRect:CGRectMake(150,120,100,200)withAttributes:attrs]; //给文本限制个矩形边界，防止矩形拉伸；
}


//- (void)setLineWidth:(CGFloat)lineWidth
//{
//    self.lineWidth = lineWidth;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
