//
//  ZYImageAniViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/20.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYImageAniViewController.h"

@interface ZYImageAniViewController () {
    UIImageView *leftImageView;
    UIImageView *rightImageView;
}

@end

@implementation ZYImageAniViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多图片动画";
    self.view.backgroundColor = [UIColor whiteColor];
    //底层图片
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 40, 200, 200)];
    backImageView.image = [UIImage imageNamed:@"5.jpeg"];
    [self.view addSubview:backImageView];
    //上层图片
    UIImageView *upImageView = [[UIImageView alloc] initWithFrame:backImageView.frame];
    upImageView.image = [UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:upImageView];
    //maskview 由两个分别加载的imageview拼接城
    UIView *maskView = [[UIView alloc] initWithFrame:upImageView.bounds];
    upImageView.maskView = maskView;
    
    leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 400)];
    leftImageView.image = [UIImage imageNamed:@"up.png"];
    [maskView addSubview:leftImageView];
    
    rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, -200, 100, 400)];
    rightImageView.image = [UIImage imageNamed:@"down.png"];
    [maskView addSubview:rightImageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"start" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    button.frame = CGRectMake(40, 300, 50, 40);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}

- (void)buttonClick {
    [UIView animateWithDuration:4.f delay:0.f options:0 animations:^{
        leftImageView.y -= 400;
        rightImageView.y += 400;
    } completion:^(BOOL finished) {
        leftImageView.frame = CGRectMake(0, 0, 100, 400);
        rightImageView.frame = CGRectMake(100, -200, 100, 400);
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
