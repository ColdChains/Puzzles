//
//  ViewController.m
//  LAX_OCAnimation
//
//  Created by 冰凉的枷锁 on 2016/11/18.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

#import "ViewController.h"
#import "AnimationViewController.h"
#import "TestViewController.h"
#import "LAXAnimation.h"

@interface ViewController ()

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //向视图添加长按晃动手势
    [LAXAnimation addShakeGestureRecognizer:_shakeImageView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //触摸屏幕 停止晃动 TouchView：触摸的视图 shakeView：晃动的视图
    [LAXAnimation stopShakeWithTouchView:self.view shakeView:_shakeImageView touches:touches event:event];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击Enter按钮
- (IBAction)enterAction:(UIButton *)sender {
    
    //添加默认切换动画
    [LAXAnimation defaultAnimationWithDuration:2 target:self.view.window];
    
    AnimationViewController *vc = [[AnimationViewController alloc] init];
    [self showViewController:vc sender:nil];
    
}

//点击Test按钮
- (IBAction)testAction:(UIButton *)sender {
    
    //添加切换动画  target:目标视图  type:动画类型 0-11  subtype:动画切换方向 0-3
    [LAXAnimation animationWithDuration:1 target:self.view.window delegate:self type:arc4random_uniform(12) subtype:arc4random_uniform(4)];
    
    TestViewController *vc = [[TestViewController alloc] init];
    [self showViewController:vc sender:nil];
    
}


// 代理 动画开始和结束后调用
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"animationDidStart");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animationDidStop");
}

@end
