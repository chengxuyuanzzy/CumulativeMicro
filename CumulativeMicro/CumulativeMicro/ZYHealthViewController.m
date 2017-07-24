//
//  ZYHealthViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/26.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYHealthViewController.h"
#import "ZYHealthKitManager.h"

@interface ZYHealthViewController ()

@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *stepCountLabel;

@end

@implementation ZYHealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"健康";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.distanceLabel];
    [self.view addSubview:self.stepCountLabel];
    
    WS(weakSelf)
    [self.distanceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.left).offset(Level*10);
        make.top.equalTo(weakSelf.view.top).offset(70);
        make.height.equalTo(Verticl*30);
    }];
    
    [self.stepCountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.right).offset(Level*-30);
        make.top.equalTo(weakSelf.distanceLabel.top);
        make.height.equalTo(Verticl*30);
    }];
    
    UIButton *distanceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [distanceButton setTitle:@"行走距离" forState:UIControlStateNormal];
    [distanceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    distanceButton.backgroundColor = [UIColor blackColor];
    distanceButton.titleLabel.font = [UIFont systemFontOfSize:Level*20];
    [distanceButton addTarget:self action:@selector(distantButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:distanceButton];
    
    UIButton *stepCountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [stepCountButton setTitle:@"行走步数" forState:UIControlStateNormal];
    [stepCountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    stepCountButton.backgroundColor = [UIColor blackColor];
    stepCountButton.titleLabel.font = [UIFont systemFontOfSize:Level*20];
    [stepCountButton addTarget:self action:@selector(stepCountButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stepCountButton];
    
    [distanceButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.distanceLabel.left);
        make.top.equalTo(weakSelf.view.top).offset(120);
        make.width.equalTo(Level*100);
        make.height.equalTo(Verticl*40);
    }];
    
    [stepCountButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.stepCountLabel.right);
        make.top.equalTo(distanceButton.top);
        make.width.equalTo(distanceButton.width);
        make.height.equalTo(distanceButton.height);
    }];
    
    // Do any additional setup after loading the view.
}
- (void)distantButtonClick {
    WS(weakSelf)
    [[ZYHealthKitManager shareManger] authorizeHealthKit:^(BOOL success, NSError *error) {
        if (success) {
            [[ZYHealthKitManager shareManger] getDistance:^(double value, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.distanceLabel.text = [NSString stringWithFormat:@"行走距离%.0f公里", value];
                });
            }];
        }else {
            AlertView(@"不支持获取健康数据");
        }
    }];
}
- (void)stepCountButtonClick {
    WS(weakSelf)
    [[ZYHealthKitManager shareManger] authorizeHealthKit:^(BOOL success, NSError *error) {
        if (success) {
            [[ZYHealthKitManager shareManger] getStepCount:^(double value, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.stepCountLabel.text = [NSString stringWithFormat:@"行走步数%.0f步", value];
                });
            }];
        }else {
            AlertView(@"不支持获取健康数据");
        }
    }];
}
#pragma - lazyLoad
- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.textColor = [UIColor blackColor];
        _distanceLabel.font = [UIFont systemFontOfSize:Level*20];
    }
    return _distanceLabel;
}

- (UILabel *)stepCountLabel {
    if (!_stepCountLabel) {
        _stepCountLabel = [[UILabel alloc] init];
        _stepCountLabel.textColor = [UIColor blackColor];
        _stepCountLabel.font = [UIFont systemFontOfSize:Level*20];
    }
    return _stepCountLabel;
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
