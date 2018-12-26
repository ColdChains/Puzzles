//
//  AnimationViewController.m
//  LAX_OC
//
//  Created by 冰凉的枷锁 on 2016/11/17.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

#import "AnimationViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kDuration 0.7   // 动画持续时间

static CATransition *defaultAnimation = nil;

@implementation AnimationViewController

// 创建动画对象
- (CATransition *)createAnimationWithType:(NSInteger)type AndSubType:(NSInteger)subtype {
    
    NSArray *typeArr = @[kCATransitionFade, kCATransitionPush, kCATransitionReveal, kCATransitionMoveIn, @"rippleEffect", @"suckEffect", @"oglFlip", @"cube", @"pageCurl", @"pageUnCurl", @"cameraIrisHollowOpen", @"cameraIrisHollowClose"];
    NSArray *subtypeArr = @[kCATransitionFromLeft, kCATransitionFromBottom, kCATransitionFromRight, kCATransitionFromTop];
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = typeArr[0];
    animation.subtype = subtypeArr[0];
    
    if (type >= 0 && type < 12) {
        animation.type = typeArr[type];
    }
    if (subtype >= 0 && subtype < 4) {
        animation.subtype = subtypeArr[subtype];
    }
    
    return animation;
    
}

// 切换动画
- (void)cutfromViewAnimation:(NSInteger)tag {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:kDuration];
    
    switch (tag) {
        case 1:
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
            break;
        case 2:
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
            break;
        case 3:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
            break;
        case 4:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
            break;
        default:
            break;
    }
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
    NSUInteger green = [[self.view subviews] indexOfObject:self.greenView];
    NSUInteger blue = [[self.view subviews] indexOfObject:self.blueView];
    [self.view exchangeSubviewAtIndex:green withSubviewAtIndex:blue];
    
}

// 切换动画
- (void)cutfromAnimationWithType:(NSInteger)type AndSubType:(NSInteger)subtype {
    
    CATransition *animation = [self createAnimationWithType:type AndSubType:subtype];
    self.subtype = (self.subtype + 1) % 4;
    [[self.view layer] addAnimation:animation forKey:@"animation"];
    
    NSUInteger green = [[self.view subviews] indexOfObject:self.greenView];
    NSUInteger blue = [[self.view subviews] indexOfObject:self.blueView];
    [self.view exchangeSubviewAtIndex:green withSubviewAtIndex:blue];
    
}

// 定时器事件
- (void)timerAction {
    
    if (arc4random_uniform(4)) {
        
        NSInteger x = arc4random_uniform(12) + 1;
        NSInteger y = arc4random_uniform(4) + 1;
        [self cutfromAnimationWithType:x AndSubType:y];
        
    } else {
        
        [self cutfromViewAnimation:arc4random_uniform(4) + 1];
        
    }
    
}

// 点击菜单按钮
- (IBAction)buttonAction:(UIButton *)sender {
    
    if (sender.tag == 11) {
        
        [LAXAnimation defaultAnimationWithDuration:2 target:self.view.window];
        [self dismissViewControllerAnimated:true completion:nil];
        
    } else if (sender.tag == 12) {
        
        if (sender.selected) {
            [self.timer invalidate];
            self.timer = nil;
        } else {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:true];
        }
        sender.selected = !sender.selected;
        
    }
    
}

// 点击按钮1
- (IBAction)buttonPressed:(UIButton *)sender {
    
    [self cutfromAnimationWithType:sender.tag - 101 AndSubType:self.subtype];
    
}

// 点击按钮2
- (IBAction)buttonPressed2:(UIButton *)sender {
    
    [self cutfromViewAnimation:sender.tag - 200];
    
}

// 代理 动画开始和结束后调用
//- (void)animationDidStart:(CAAnimation *)anim {
//    NSLog(@"animationDidStart");
//}
//
//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    NSLog(@"animationDidStop");
//}

- (void)test {
    
    [UIView animateWithDuration:1.25 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(1.2, 1.2);
        [self.blueView setTransform:transform];
        [self.greenView setTransform:transform];
    }completion:^(BOOL finished) {
        if (finished) {
            
            [UIView animateWithDuration:1.2 animations:^{
                [self.blueView setAlpha:0];
                [self.greenView setAlpha:0];
            } completion:^(BOOL finished) {
                [self.blueView removeFromSuperview];
                [self.greenView removeFromSuperview];
            }];
        }
    }];
    
}

@end
