//
//  ZYPictureViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/14.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYPictureViewController.h"
#import "ZYHeaderTensileViewController.h"
#import "ZYDrawerViewController.h"
#import "ZYShapeLayerViewController.h"


@interface ZYPictureViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation ZYPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片处理";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
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
            ZYHeaderTensileViewController *tensileVC = [[ZYHeaderTensileViewController alloc] init];
            [self.navigationController pushViewController:tensileVC animated:YES];
        }
            break;
        case 1: {
            ZYDrawerViewController *drawerVC = [[ZYDrawerViewController alloc] init];
            [self.navigationController pushViewController:drawerVC animated:YES];
        }
            break;
        case 2: {
            ZYShapeLayerViewController *shapeVC = [[ZYShapeLayerViewController alloc] init];
            [self.navigationController pushViewController:shapeVC animated:YES];
        }
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
        _dataArray = @[@"tableview头部图片拉伸", @"抽屉视图", @"CAShapeLayer"];
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
