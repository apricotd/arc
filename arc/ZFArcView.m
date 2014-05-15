//
//  ZFArcView.m
//  arc
//
//  Created by tarena on 14-5-15.
//  Copyright (c) 2014年 tarena. All rights reserved.
//

#import "ZFArcView.h"

@implementation ZFArcView
@synthesize myArc;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        myArc = [[ZFArc alloc]init];
        myArc.centerIsExist = NO;
        myArc.arcIsExist    = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextBeginPath(context);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    if (myArc.arcIsExist == NO) {
        CGFloat lengths[] = {5,10};
        CGContextSetLineDash(context, 0, lengths, 2);
        CGContextMoveToPoint(context, myArc.center.x, myArc.center.y);
        CGContextAddLineToPoint(context, myArc.firstPoint.x, myArc.firstPoint.y);
        CGContextStrokePath(context);
    }else
    {
        CGFloat lengths[] = {5,10};
        CGContextSetLineDash(context, 0, lengths, 2);
        CGContextMoveToPoint(context, myArc.center.x, myArc.center.y);
        CGContextAddLineToPoint(context, myArc.firstPoint.x, myArc.firstPoint.y);
        CGContextStrokePath(context);
    
        CGContextSetLineDash(context, 0, 0, 0);
        CGContextAddArc(context, myArc.center.x, myArc.center.y, myArc.r1, myArc.startAngle, myArc.endAngle, 0);
        CGContextStrokePath(context);
        
        
        CGContextSetLineDash(context, 0, lengths, 2);
        CGContextMoveToPoint(context, myArc.center.x, myArc.center.y);
        CGContextAddLineToPoint(context, myArc.secondPointAtArc.x, myArc.secondPointAtArc.y);
        CGContextStrokePath(context);
        
    }
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (myArc.centerIsExist == NO) {
        UITouch *touch = [touches anyObject];
        myArc.center = [touch locationInView:self];
        myArc.centerIsExist = YES;
    }else{
        myArc.arcIsExist = YES;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (myArc.arcIsExist == NO) {
        
        myArc.firstPoint = [touch locationInView:self];
        [self setNeedsDisplay];
    }
    else if (myArc.arcIsExist) {
        myArc.secondPoint = [touch locationInView:self];
        CGFloat x = myArc.secondPoint.x-myArc.center.x;
        CGFloat y = myArc.secondPoint.y-myArc.center.y;
        myArc.r2 = sqrt((x*x)+(y*y));
        x = (myArc.r1/myArc.r2)*(myArc.secondPoint.x -myArc.center.x)+myArc.center.x;
        y = (myArc.r1/myArc.r2)*(myArc.secondPoint.y -myArc.center.y)+myArc.center.y;
        myArc.secondPointAtArc = CGPointMake(x, y);
        //        NSLog(@"%f",sqrt((myArc.secondPointAtArc.x -myArc.center.x) *(myArc.secondPointAtArc.x -myArc.center.x) +(myArc.secondPointAtArc.y -myArc.center.y)*(myArc.secondPointAtArc.y -myArc.center.y)));
        
        x = myArc.firstPoint.x-(myArc.center.x+myArc.r1);
        y = myArc.firstPoint.y-myArc.center.y;
        CGFloat chord = sqrt(x*x+y*y);
        CGFloat angle = asin((chord)/2 /myArc.r1)*2;
        if (myArc.firstPoint.y-myArc.center.y > 0) {
            myArc.startAngle = angle;
        }else{
            myArc.startAngle = 2*M_PI - angle;
        }
        NSLog(@"%f",myArc.startAngle);
        x = myArc.secondPointAtArc.x-(myArc.center.x+myArc.r1);
        y = myArc.secondPointAtArc.y-myArc.center.y;
        chord = sqrt((x*x+y*y));
        angle = asin((chord)/2 /myArc.r1)*2;
        if (myArc.secondPointAtArc.y-myArc.center.y > 0) {
            myArc.endAngle = angle;
        }else{
            myArc.endAngle = 2*M_PI - angle;
        }
        NSLog(@"%f",myArc.endAngle);
        [self setNeedsDisplay];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (myArc.arcIsExist == NO) {
        myArc.firstPoint = [touch locationInView:self];
        CGFloat x = myArc.firstPoint.x-myArc.center.x;
        CGFloat y = myArc.firstPoint.y-myArc.center.y;
        myArc.r1 = sqrt((x*x)+(y*y));
    }
    else if (myArc.arcIsExist) {
        myArc.secondPoint = [touch locationInView:self];
        CGFloat x = myArc.secondPoint.x-myArc.center.x;
        CGFloat y = myArc.secondPoint.y-myArc.center.y;
        myArc.r2 = sqrt((x*x)+(y*y));
        x = (myArc.r1/myArc.r2)*(myArc.secondPoint.x -myArc.center.x)+myArc.center.x;
        y = (myArc.r1/myArc.r2)*(myArc.secondPoint.y -myArc.center.y)+myArc.center.y;
        myArc.secondPointAtArc = CGPointMake(x, y);
        x = myArc.firstPoint.x-(myArc.center.x+myArc.r1);
        y = myArc.firstPoint.y-myArc.center.y;
        CGFloat chord = sqrt(x*x+y*y);
        CGFloat angle = asin((chord)/2 /myArc.r1)*2;
        if (myArc.firstPoint.y-myArc.center.y > 0) {
            myArc.startAngle = angle;
        }else{
            myArc.startAngle = 2*M_PI - angle;
        }
        NSLog(@"%f",myArc.startAngle);
        x = myArc.secondPointAtArc.x-(myArc.center.x+myArc.r1);
        y = myArc.secondPointAtArc.y-myArc.center.y;
        chord = sqrt((x*x+y*y));
        angle = asin((chord)/2 /myArc.r1)*2;
        if (myArc.secondPointAtArc.y-myArc.center.y > 0) {
            myArc.endAngle = angle;
        }else{
            myArc.endAngle = 2*M_PI - angle;
        }
        NSLog(@"%f",myArc.endAngle);
        [self setNeedsDisplay];
    }
    

}

@end
