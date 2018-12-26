//
//  ViewController.h
//  LAX_OCAnimation
//
//  Created by 冰凉的枷锁 on 2016/11/18.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController <CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *shakeImageView;

@end

