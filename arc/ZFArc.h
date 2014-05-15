//
//  ZFArc.h
//  arc
//
//  Created by tarena on 14-5-15.
//  Copyright (c) 2014年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFArc : NSObject

@property(nonatomic,assign)CGPoint center;
@property(nonatomic,assign)CGPoint firstPoint;
@property(nonatomic,assign)CGPoint secondPoint;
@property(nonatomic,assign)CGPoint secondPointAtArc;

@property(nonatomic,assign)CGFloat r1;
@property(nonatomic,assign)CGFloat r2;
@property(nonatomic,assign)CGFloat startAngle;
@property(nonatomic,assign)CGFloat endAngle;

@property(nonatomic,assign)BOOL centerIsExist;
@property(nonatomic,assign)BOOL arcIsExist;

@end
