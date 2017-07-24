//
//  ZYEffectViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/20.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYEffectViewController.h"

@interface ZYEffectViewController ()

@end

@implementation ZYEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"毛玻璃渐变";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"5.jpeg"];
    [self.view addSubview:imageView];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [self.view.layer addSublayer:gradientLayer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:1 alpha:0].CGColor,
                             (__bridge id)[UIColor colorWithWhite:1 alpha:1].CGColor];
    gradientLayer.locations = @[@0.35, @0.55];
    
    UIImageView *blurImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //    blurImageView.contentMode = UIViewContentModeScaleAspectFill;
    blurImageView.image = [UIImage imageNamed:@"5.jpeg"];
    blurImageView.userInteractionEnabled = YES;
    [self.view addSubview:blurImageView];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha = 0.7f;
    effectView.frame = CGRectMake(0, 0, blurImageView.frame.size.width, blurImageView.frame.size.height);
    [blurImageView addSubview:effectView];
    
    blurImageView.layer.mask = gradientLayer;
    
    // Do any additional setup after loading the view.
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
