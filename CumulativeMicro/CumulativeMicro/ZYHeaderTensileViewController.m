//
//  ZYHeaderTensileViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/14.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYHeaderTensileViewController.h"

#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import <MMDrawerController/MMDrawerVisualState.h>

@interface ZYHeaderTensileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, assign) BOOL isWidthTensile;

@end

@implementation ZYHeaderTensileViewController

static CGFloat kImageHeigth = 300;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"tableview头部图片拉伸";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.headerImageView];
    self.isWidthTensile = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"左" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"右" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    
    
    // Do any additional setup after loading the view.
}

- (void)leftButtonClick {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)rightButtonClick {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        CGFloat yOffset = scrollView.contentOffset.y;
        CGFloat xOffset = (yOffset + kImageHeigth)/2;
        if (yOffset < -kImageHeigth) {
            CGRect f = self.headerImageView.frame;
            f.origin.y = yOffset;
            f.size.height = -yOffset;
            if (self.isWidthTensile) {
                f.origin.x = xOffset;
                f.size.width = WIDTH + fabs(xOffset)*2;
            }
            self.headerImageView.frame = f;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Verticl*40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = @"点我就可以切换是否拉伸宽度";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isWidthTensile) {
        self.isWidthTensile = NO;
        [self.view makeToast:@"不拉伸宽度"];
    }else {
        self.isWidthTensile = YES;
        [self.view makeToast:@"宽度会被拉伸"];
    }
}

#pragma - lazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(kImageHeigth, 0, 0, 0);
    }
    return _tableView;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5.jpeg"]];
        _headerImageView.userInteractionEnabled = YES;
        _headerImageView.frame = CGRectMake(0, -kImageHeigth, WIDTH, kImageHeigth);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [_headerImageView addGestureRecognizer:tap];
    }
    return _headerImageView;
}

- (void)tapClick {
    [self.navigationController popViewControllerAnimated:YES];
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
