//
//  ZYQrCodeViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/15.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYQrCodeViewController.h"
#import "ZYQrCodeModel.h"
#import "ZYScanQrCodeViewController.h"
#import "ZYGenerateQrCodeViewController.h"

@interface ZYQrCodeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZYQrCodeModel *model;


@end

@implementation ZYQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.dataArray.count;
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
    cell.textLabel.text = self.model.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZYScanQrCodeViewController *scanVC = [[ZYScanQrCodeViewController alloc] init];
        [self.navigationController pushViewController:scanVC animated:YES];
    }else if (indexPath.row == 1) {
        ZYGenerateQrCodeViewController *generateVC = [[ZYGenerateQrCodeViewController alloc] init];
        [self.navigationController pushViewController:generateVC animated:YES];
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

- (ZYQrCodeModel *)model {
    if (!_model) {
        _model = [[ZYQrCodeModel alloc] init];
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
