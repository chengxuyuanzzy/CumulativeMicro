//
//  ZYCalculatorViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/9.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYCalculatorViewController.h"
#import "ZYCalculatorView.h"
#import "ZYCalculatorViewModel.h"
#import "ZYMainViewController.h"

@interface ZYCalculatorViewController ()

@property (nonatomic, strong) ZYCalculatorView *calculatorView;

@property (nonatomic, strong) ZYCalculatorViewModel *calculatorViewModel;

@end

@implementation ZYCalculatorViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}
//下一个页面已经出现了导航条才显示
//- (void)viewDidDisappear:(BOOL)animated {
//    self.navigationController.navigationBarHidden = NO;
//}
//下一个页面出现之前导航条显示(效果更好一点)
- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.calculatorView];
    
    WS(weakSelf)
    [self.calculatorView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    @weakify(self);
    [self.calculatorViewModel.clickSubject subscribeNext:^(id x) {
        @strongify(self);
        if ([x isEqualToString:@"1"]) {
            ZYMainViewController *mainVC = [[ZYMainViewController alloc] init];
            [self.navigationController pushViewController:mainVC animated:YES];
        }
    }];
    // Do any additional setup after loading the view.
}
#pragma - lazyLoad
- (ZYCalculatorView *)calculatorView {
    if (!_calculatorView) {
        _calculatorView = [[ZYCalculatorView alloc] init];
        [_calculatorView initWithViewModel:self.calculatorViewModel];
        _calculatorView.backgroundColor = [UIColor whiteColor];
    }
    return _calculatorView;
}

- (ZYCalculatorViewModel *)calculatorViewModel {
    if (!_calculatorViewModel) {
        _calculatorViewModel = [[ZYCalculatorViewModel alloc] init];
    }
    return _calculatorViewModel;
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
