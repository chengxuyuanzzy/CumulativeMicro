//
//  ZYCyclePictureViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/12.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYCyclePictureViewController.h"
#import "ZYCyclePictureView.h"
#import "ZYCyclePictureViewModel.h"

@interface ZYCyclePictureViewController ()

@property (nonatomic, strong) ZYCyclePictureView *cyclePictureView;

@property (nonatomic, strong) ZYCyclePictureViewModel *cyclePictureViewModel;

@end

@implementation ZYCyclePictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"轮播图";
    
    [self.view addSubview:self.cyclePictureView];
    
    WS(weakSelf)
    [self.cyclePictureView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    // Do any additional setup after loading the view.
}
#pragma - lazyLoad
- (ZYCyclePictureView *)cyclePictureView {
    if (!_cyclePictureView) {
        _cyclePictureView = [[ZYCyclePictureView alloc] initWithViewModel:self.cyclePictureViewModel];
    }
    return _cyclePictureView;
}

- (ZYCyclePictureViewModel *)cyclePictureViewModel {
    if (!_cyclePictureViewModel) {
        _cyclePictureViewModel = [[ZYCyclePictureViewModel alloc] init];
    }
    return _cyclePictureViewModel;
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
