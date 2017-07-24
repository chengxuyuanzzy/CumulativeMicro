//
//  ZYGradientLayerViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/20.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYGradientLayerViewController.h"
#import "UIView+Frame.h"

@interface ZYGradientLayerViewController ()

@property (nonatomic, strong) UILabel *lockLabel;

@end

@implementation ZYGradientLayerViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.backItem.hidesBackButton = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CAGradientLayer";
    self.view.backgroundColor = [UIColor grayColor];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [self.view.layer addSublayer:gradientLayer];
    gradientLayer.frame = CGRectMake(0, 200, self.view.kWidth, 64);
    gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,
                             (__bridge id)[UIColor whiteColor].CGColor,
                             (__bridge id)[UIColor blackColor].CGColor];
    gradientLayer.locations = @[@0.25, @0.5, @0.75];
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    
    CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"locations"];
    basicAni.fromValue = @[@0, @0, @0.25];
    basicAni.toValue = @[@0.75, @1, @1];
    basicAni.duration = 2.5;
    basicAni.repeatCount = HUGE;
    [gradientLayer addAnimation:basicAni forKey:nil];
    
    self.lockLabel = [[UILabel alloc] initWithFrame:gradientLayer.bounds];
    self.lockLabel.alpha = 0.5f;
    self.lockLabel.text = @"滑动解锁 >>";
    self.lockLabel.textAlignment = NSTextAlignmentCenter;
    self.lockLabel.font = [UIFont systemFontOfSize:30];
    gradientLayer.mask = self.lockLabel.layer;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
    [self.view addGestureRecognizer:swipe];
    
    // Do any additional setup after loading the view.
}
- (void)swipeRecognizer:(UISwipeGestureRecognizer *)swipe {
    [UIView animateWithDuration:3 animations:^{
        [self.view makeToast:@"解锁成功"];
    }completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
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
