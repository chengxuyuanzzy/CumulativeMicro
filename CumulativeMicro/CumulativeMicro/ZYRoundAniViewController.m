//
//  ZYRoundAniViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/20.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYRoundAniViewController.h"

@interface ZYRoundAniViewController ()

@end

@implementation ZYRoundAniViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RoundAnimation";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(10, 80, 100, 100)];
    [self.view addSubview:roundView];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = roundView.bounds;
    //    shapeLayer.strokeEnd = 0.4f;
    //    shapeLayer.strokeStart = 0.f;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:roundView.bounds];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor greenColor].CGColor;
    shapeLayer.lineWidth = 4.f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [roundView.layer addSublayer:shapeLayer];
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 5.f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.f];
    pathAnima.toValue = [NSNumber numberWithFloat:0.7f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
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
