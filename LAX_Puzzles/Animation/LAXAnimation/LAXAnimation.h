//
//  LAXAnimation.h
//  LAX_OCAnimation
//
//  Created by 冰凉的枷锁 on 2016/11/18.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LAXAnimation : NSObject

@property (nonatomic, assign) NSTimer *timer;

+ (CATransition *)defaultAnimationWithDuration:(NSTimeInterval)duration target:(UIView *)view;
+ (CATransition *)animationWithDuration:(NSTimeInterval)duration target:(UIView *)view delegate:(id)delegate type:(NSInteger)type subtype:(NSInteger)subtype;

+ (void)addShakeGestureRecognizer:(UIView *)view;
+ (void)stopShakeWithTouchView:(UIView *)contentView shakeView:(UIView *)shakeView touches:(NSSet<UITouch *> *)touches event:(UIEvent *)event;

@end
