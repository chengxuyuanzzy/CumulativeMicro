//
//  ZYHungryViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/21.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYHungryViewController.h"
#import "ZYHungryTwoView.h"
#import "ZYHungryModel.h"
#import "ZYHungryViewModel.h"

@interface ZYHungryViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) ZYHungryTwoView *hungryView;

@property (nonatomic, strong) ZYHungryModel *model;

@property (nonatomic, strong) ZYHungryViewModel *viewModel;

@end

@implementation ZYHungryViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.hungryView];
    
    WS(weakSelf)
    [self.hungryView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    // Do any additional setup after loading the view.
}
#pragma - lazyLoad
- (ZYHungryViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZYHungryViewModel alloc] init];
        [_viewModel loadDataWithSuccess:^(ZYHungryModel *model) {
            self.model = model;
        } failure:^{
            
        }];
    }
    return _viewModel;
}

- (ZYHungryTwoView *)hungryView {
    if (!_hungryView) {
        _hungryView = [[ZYHungryTwoView alloc] initWithModel:self.viewModel model:self.model];
    }
    return _hungryView;
}

- (ZYHungryModel *)model {
    if (!_model) {
        _model = [[ZYHungryModel alloc] init];
    }
    return _model;
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
