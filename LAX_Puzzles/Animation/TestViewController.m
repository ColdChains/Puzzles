//
//  TestViewController.m
//  LAX_OCAnimation
//
//  Created by 冰凉的枷锁 on 2016/11/18.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)returnAction:(UIButton *)sender {
    
    //添加切换动画
    [LAXAnimation animationWithDuration:1 target:self.view.window delegate:nil type:arc4random_uniform(12) subtype:arc4random_uniform(4)];
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}


@end
