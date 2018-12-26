//
//  AnimationViewController.h
//  LAX_OC
//
//  Created by 冰凉的枷锁 on 2016/11/17.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LAXAnimation.h"

@interface AnimationViewController : UIViewController <CAAnimationDelegate>

@property (nonatomic, assign) NSInteger subtype;
@property (nonatomic, assign) NSTimer *timer;

@property (nonatomic, retain) IBOutlet UIImageView *blueView;
@property (nonatomic, retain) IBOutlet UIImageView *greenView;

@end
