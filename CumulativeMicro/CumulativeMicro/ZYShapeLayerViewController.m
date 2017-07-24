//
//  ZYShapeLayerViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/19.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYShapeLayerViewController.h"
#import "CAShapeLayer+ViewMask.h"
#import "ZYMaskViewController.h"
#import "ZYRoundAniViewController.h"
#import "ZYImageAniViewController.h"
#import "ZYGradientLayerViewController.h"
#import "ZYFrostedViewController.h"
#import "ZYEffectViewController.h"
#import "ZYNameAniViewController.h"
#import "ZYPracticeLayerViewController.h"

@interface ZYShapeLayerViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ZYShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"CAShapeLayer";
    
    [self.view addSubview:self.tableView];
    
//    UILabel*tipLabel = [[UILabel alloc] init];
//    tipLabel.text = @"其实这些完全可以通过UI所给图片进行实现，但这样会浪费APP的资源存储空间，第二个画圆是通过贝塞尔椭圆方法积CABasicAnimation实现";
//    tipLabel.textColor = [UIColor blackColor];
//    tipLabel.font = [UIFont systemFontOfSize:Level*15.f];
//    tipLabel.numberOfLines = 0;
//    [self.view addSubview:tipLabel];
//    
//    WS(weakSelf)
//    [tipLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.view.left);
//        make.top.equalTo(weakSelf.view.top).offset(10);
//        make.right.equalTo(weakSelf.view.right);
//    }];
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Verticl*40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            ZYMaskViewController *maskVC = [[ZYMaskViewController alloc] init];
            [self.navigationController pushViewController:maskVC animated:YES];
        }
            break;
        case 1: {
            ZYRoundAniViewController *roundVC = [[ZYRoundAniViewController alloc] init];
            [self.navigationController pushViewController:roundVC animated:YES];
        }
            break;
        case 2: {
            ZYImageAniViewController *imageVC = [[ZYImageAniViewController alloc] init];
            [self.navigationController pushViewController:imageVC animated:YES];
        }
            break;
        case 3: {
            ZYGradientLayerViewController *gradientVC = [[ZYGradientLayerViewController alloc] init];
            [self.navigationController pushViewController:gradientVC animated:YES];
        }
            break;
        case 4: {
            ZYFrostedViewController *frostedVC = [[ZYFrostedViewController alloc] init];
            [self.navigationController pushViewController:frostedVC animated:YES];
        }
            break;
        case 5: {
            ZYEffectViewController *effectVC = [[ZYEffectViewController alloc] init];
            [self.navigationController pushViewController:effectVC animated:YES];
        }
            break;
        case 6: {
            ZYNameAniViewController *nameVC = [[ZYNameAniViewController alloc] init];
            [self.navigationController pushViewController:nameVC animated:YES];
        }
            break;
        case 7: {
            ZYPracticeLayerViewController *practiceVC = [[ZYPracticeLayerViewController alloc] init];
            [self.navigationController pushViewController:practiceVC animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma - lazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"Mask", @"RoundAni", @"多图片动画", @"颜色渐变（滑动解锁）", @"毛玻璃效果配合CAShapeLayer", @"毛玻璃渐变", @"CAShapeLayer画名字", @"CAShapeLayer练习"];
    }
    return _dataArray;
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
