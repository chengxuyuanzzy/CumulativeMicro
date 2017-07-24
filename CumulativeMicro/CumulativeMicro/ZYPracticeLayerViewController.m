//
//  ZYPracticeLayerViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/21.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYPracticeLayerViewController.h"

@interface ZYPracticeLayerViewController ()

@end

@implementation ZYPracticeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"练习CAShapeLayer";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self create1];
    [self create2];
    [self create3];
    // Do any additional setup after loading the view.
}
- (void)create1 {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(10, 65, 100, 50)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor yellowColor].CGColor;
    layer.strokeColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:layer];
}
- (void)create2 {
    CGPoint startPoint = CGPointMake(200, 100);
    CGPoint endPoint = CGPointMake(WIDTH-10, 100);
    CGPoint point1 = CGPointMake(250, 60);
    CGPoint point2 = CGPointMake(300, 200);
    
//    CALayer *layer1 = [[CALayer alloc] init];
//    layer1.frame = CGRectMake(startPoint.x, startPoint.y, 5, 5);
////    layer1.backgroundColor = [UIColor redColor].CGColor;
//    [self.view.layer addSublayer:layer1];
//    
//    CALayer *layer2 = [[CALayer alloc] init];
//    layer2.frame = CGRectMake(point1.x, point1.y, 5, 5);
////    layer2.backgroundColor = [UIColor redColor].CGColor;
//    [self.view.layer addSublayer:layer2];
//    
//    CALayer *layer3 = [[CALayer alloc] init];
//    layer3.frame = CGRectMake(point2.x, point2.y, 5, 5);
////    layer3.backgroundColor = [UIColor redColor].CGColor;
//    [self.view.layer addSublayer:layer3];
//    
//    CALayer *layer4 = [[CALayer alloc] init];
//    layer4.frame = CGRectMake(endPoint.x, endPoint.y, 5, 5);
////    layer4.backgroundColor = [UIColor redColor].CGColor;
//    [self.view.layer addSublayer:layer4];
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:startPoint];
    [path addCurveToPoint:endPoint controlPoint1:point1 controlPoint2:point2];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    [self.view.layer addSublayer:shapeLayer];
    
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.lineWidth = 5;
}
- (void)create3 {
    CGPoint point1 = CGPointMake(0, 250);
    CGPoint point2 = CGPointMake(0, 300);
    CGPoint point3 = CGPointMake(WIDTH, 300);
    CGPoint point4 = CGPointMake(WIDTH, 250);
    CGPoint point5 = CGPointMake(WIDTH/2, 200);
//    CGPoint point6 = CGPointMake(WIDTH/2, 350);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
//    [path addQuadCurveToPoint:point3 controlPoint:point6];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addQuadCurveToPoint:point1 controlPoint:point5];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 230, 30, 20)];
    label1.text = @"1";
    label1.textColor = [UIColor blackColor];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, 30, 20)];
    label2.text = @"2";
    label2.textColor = [UIColor blackColor];
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-10, 320, 30, 20)];
    label3.text = @"3";
    label3.textColor = [UIColor blackColor];
    [self.view addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-10, 230, 30, 20)];
    label4.text = @"4";
    label4.textColor = [UIColor blackColor];
    [self.view addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2, 180, 30, 20)];
    label5.text = @"5";
    label5.textColor = [UIColor blackColor];
    [self.view addSubview:label5];
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
