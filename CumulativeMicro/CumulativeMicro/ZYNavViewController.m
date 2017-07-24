//
//  ZYNavViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/9.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYNavViewController.h"

@interface ZYNavViewController ()

@end

@implementation ZYNavViewController

+ (void)initialize {
    NSMutableDictionary *attrNav = [NSMutableDictionary dictionary];
    attrNav[NSFontAttributeName] = [UIFont systemFontOfSize:20.f];
    attrNav[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTitleTextAttributes:attrNav];
    
    navBar.tintColor = [UIColor whiteColor];
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *attrItem = [NSMutableDictionary dictionary];
    attrItem[NSFontAttributeName] = [UIFont systemFontOfSize:17.f];
    attrItem[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:attrItem forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
