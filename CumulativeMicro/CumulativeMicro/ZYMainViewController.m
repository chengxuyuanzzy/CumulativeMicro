//
//  ZYMainViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/12.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYMainViewController.h"
#import "ZYMainView.h"
#import "ZYMainViewModel.h"
#import "ZYCyclePictureViewController.h"
#import "ZYPictureViewController.h"
#import "ZYQrCodeViewController.h"
#import "ZYDoubleTableViewController.h"
#import "ZYHealthViewController.h"
#import "ZYGestureViewController.h"
#import "ZYDynamicViewController.h"

@interface ZYMainViewController ()

@property (nonatomic, strong) ZYMainView *mainView;

@property (nonatomic, strong) ZYMainViewModel *mainViewModel;

@end

@implementation ZYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"列表";
    
    [self.view addSubview:self.mainView];
    
    WS(weakSelf)
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    @weakify(self);
    [[self.mainViewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        switch ([x integerValue]) {
            case 0: {
                ZYCyclePictureViewController *cycleVC = [[ZYCyclePictureViewController alloc] init];
                [self.navigationController pushViewController:cycleVC animated:YES];
            }
                break;
            case 1: {
                ZYPictureViewController *pictureVC = [[ZYPictureViewController alloc] init];
                [self.navigationController pushViewController:pictureVC animated:YES];
            }
                break;
            case 2: {
                ZYQrCodeViewController *QrCodeVC = [[ZYQrCodeViewController alloc] init];
                [self.navigationController pushViewController:QrCodeVC animated:YES];
            }
                break;
            case 3: {
                ZYDoubleTableViewController *doubleVC = [[ZYDoubleTableViewController alloc] init];
                [self.navigationController pushViewController:doubleVC animated:YES];
            }
                break;
            case 4: {
                ZYHealthViewController *healthVC = [[ZYHealthViewController alloc] init];
                [self.navigationController pushViewController:healthVC animated:YES];
            }
                break;
            case 5: {
                ZYGestureViewController *gestureVC = [[ZYGestureViewController alloc] init];
                [self.navigationController pushViewController:gestureVC animated:YES];
            }
                break;
            case 6: {
                ZYDynamicViewController *dynamicVC = [[ZYDynamicViewController alloc] init];
                [self.navigationController pushViewController:dynamicVC animated:YES];
            }
                break;
            default:
                break;
        }
    }];
    // Do any additional setup after loading the view.
}

#pragma - lazyLoad
- (ZYMainView *)mainView {
    if (!_mainView) {
        _mainView = [[ZYMainView alloc] init];
        [_mainView initWithViewModel:self.mainViewModel];
    }
    return _mainView;
}

- (ZYMainViewModel *)mainViewModel {
    if (!_mainViewModel) {
        _mainViewModel = [[ZYMainViewModel alloc] init];
    }
    return _mainViewModel;
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
