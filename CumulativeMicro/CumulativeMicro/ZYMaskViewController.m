//
//  ZYMaskViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/20.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYMaskViewController.h"
#import "CAShapeLayer+ViewMask.h"

@interface ZYMaskViewController ()

@end

@implementation ZYMaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Mask";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 100, 100)];
    imageView.image = [UIImage imageNamed:@"3.jpg"];
    [self.view addSubview:imageView];
    
    CAShapeLayer *layer = [CAShapeLayer createLanguageMaskLayerWithView:imageView];
    imageView.layer.mask = layer;
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
