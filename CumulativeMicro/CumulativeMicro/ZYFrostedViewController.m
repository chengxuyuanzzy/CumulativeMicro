//
//  ZYFrostedViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/20.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYFrostedViewController.h"

#define DEGREES(degrees) ((M_PI * (degrees))/180.f)

@interface ZYFrostedViewController ()

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation ZYFrostedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"毛玻璃效果";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"6.jpeg"];
    [self.view addSubview:imageView];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:100 startAngle:DEGREES(0) endAngle:DEGREES(360) clockwise:YES];
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.path = path.CGPath;
    _maskLayer.fillColor = [UIColor whiteColor].CGColor;
    _maskLayer.position = self.view.center;
    
    UIImageView *blurImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    blurImageView.contentMode = UIViewContentModeScaleAspectFill;
    blurImageView.image = [UIImage imageNamed:@"6.jpeg"];
    blurImageView.userInteractionEnabled = YES;
    [self.view addSubview:blurImageView];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha = 0.7f;
    effectView.frame = CGRectMake(0, 0, blurImageView.frame.size.width, blurImageView.frame.size.height);
    [blurImageView addSubview:effectView];
    
    blurImageView.layer.mask = _maskLayer;
    
    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    showView.backgroundColor = [UIColor clearColor];
    showView.center = self.view.center;
    [self.view addSubview:showView];
    
    UIPanGestureRecognizer *recognzier = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [showView addGestureRecognizer:recognzier];
    // Do any additional setup after loading the view.
}
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer
     setTranslation:CGPointMake(0, 0) inView:self.view];
    [CATransaction setDisableActions:YES];
    _maskLayer.position = recognizer.view.center;
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
