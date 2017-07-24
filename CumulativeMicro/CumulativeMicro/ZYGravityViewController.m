//
//  ZYGravityViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/7/10.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYGravityViewController.h"
#import <UIKit/UIKit.h>
#import "ZYPrompt.h"

@interface ZYGravityViewController () <UICollisionBehaviorDelegate> {
    UIDynamicAnimator *animator;
//    UIGravityBehavior *gravity;
}

@end

@implementation ZYGravityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重力仿真";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(170, 70, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    //特别奇怪的一点，如果不把UIDynamicAnimator设置成全局变量就没有重力效果，原因未知
    // 1. 谁来仿真？UIDynamicAnimator来负责仿真
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    // 2. 仿真个什么动作？自由落体
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[view]];
//    // 3. 开始仿真
    [animator addBehavior :gravity];
    //碰撞检测
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[view]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    collision.collisionDelegate = self;
    
    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 200, 30)];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:yellowView.frame];
    [collision addBoundaryWithIdentifier:@"yellow" forPath:bezierPath];
    
    [animator addBehavior:collision];
    
    UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc] initWithItems:@[view]];
    item.elasticity = 0.8;
    [animator addBehavior:item];
    // Do any additional setup after loading the view.
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    [ZYPrompt soundVendorsWithResource:@"5383" extension:@".mp3"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
