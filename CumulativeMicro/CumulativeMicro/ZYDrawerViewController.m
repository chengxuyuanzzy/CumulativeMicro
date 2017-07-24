//
//  ZYDrawerViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/16.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYDrawerViewController.h"
#import "ZYDrawerView.h"
#import "ZYMenuView.h"
#import <RESideMenu/RESideMenu.h>
#import "ZYPictureViewController.h"

@interface ZYDrawerViewController () {
    CGPoint drawerViewTrans;
    UITapGestureRecognizer *tap;
}

@property (nonatomic, strong) ZYDrawerView *drawerView;

@property (nonatomic, strong) ZYMenuView *menuView;

@property (nonatomic, strong) UIView *maskView;

@end

@implementation ZYDrawerViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationItem.hidesBackButton = YES;
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"抽屉视图";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.drawerView];
    [self.drawerView addSubview:self.maskView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
    [self.drawerView addGestureRecognizer:pan];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizer:)];
    tap.enabled = NO;
    [self.drawerView addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

- (void)leftButtonClick {
    self.maskView.alpha = 0.2f;
    [UIView animateWithDuration:0.3 animations:^{
        [tap setEnabled:YES];
        self.drawerView.center = CGPointMake(Level*490, HEIGHT/2);
        
        self.menuView.center = CGPointMake((Level*490)/3-Level*15, HEIGHT/2);
        self.maskView.hidden = NO;
    }];
}

- (void)panRecognizer:(UITapGestureRecognizer *)recognizer {
    //视图前置操作
    [recognizer.view.superview bringSubviewToFront:recognizer.view];
    [UIView animateWithDuration:0.3 animations:^{
        recognizer.view.center = CGPointMake(WIDTH/2, HEIGHT/2);
        
        self.menuView.center = CGPointMake((WIDTH/2)/3-Level*15, HEIGHT/2);
        self.maskView.alpha = 0.2-(0.2/0.3);
    }completion:^(BOOL finished) {
        self.maskView.hidden = YES;
        [tap setEnabled:NO];
    }];
    
}

- (void)swipeRecognizer:(UIPanGestureRecognizer *)recognizer {
    //视图前置操作
    [recognizer.view.superview bringSubviewToFront:recognizer.view];
    
    CGPoint center = recognizer.view.center;
    CGFloat cornerRadius = recognizer.view.frame.size.width / 2;
    CGPoint translation = [recognizer translationInView:self.view];

    CGFloat transAndCenter = center.x+translation.x;
    
    if (transAndCenter > cornerRadius && transAndCenter < Level*490) {
        recognizer.view.center = CGPointMake(center.x + translation.x, HEIGHT/2);
        [recognizer setTranslation:CGPointZero inView:self.view];
        
        self.menuView.center = CGPointMake((center.x + translation.x)/3-Level*15, HEIGHT/2);
        
        self.maskView.alpha = 0.1f;
        self.maskView.hidden = NO;
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (transAndCenter > WIDTH-Level*50) {
            [UIView animateWithDuration:0.2 animations:^{
                [tap setEnabled:YES];
                recognizer.view.center = CGPointMake(Level*490, HEIGHT/2);
                [recognizer setTranslation:CGPointZero inView:self.view];
                
                self.menuView.center = CGPointMake((Level*490)/3-Level*15, HEIGHT/2);
                self.maskView.hidden = NO;
                self.maskView.alpha = 0.2f;
            }];
        }else {
            [UIView animateWithDuration:0.2 animations:^{
                recognizer.view.center = CGPointMake(WIDTH/2, HEIGHT/2);
                [recognizer setTranslation:CGPointZero inView:self.view];
                
                self.menuView.center = CGPointMake((WIDTH/2)/3-Level*15, HEIGHT/2);
                self.maskView.alpha = 0;
            }completion:^(BOOL finished) {
                self.maskView.hidden = YES;
            }];
        }
    }
}
#pragma - lazyLoad
- (ZYDrawerView *)drawerView {
    if (!_drawerView) {
        _drawerView = [[ZYDrawerView alloc] initWithFrame:self.view.bounds];
        WS(weakSelf)
        
        _drawerView.didSelectRow = ^(NSInteger row) {
            NSDictionary *dic = [NSDictionary dictionary];
            switch (row) {
                case 0: {
                    dic = @{@"status":@"one"};
                }
                    break;
                case 1: {
                    dic = @{@"status":@"two"};
                }
                    break;
                case 2: {
                    dic = @{@"status":@"three"};
                }
                    break;
                case 3: {
//                    [weakSelf.sideMenuViewController setContentViewController:[[ZYPictureViewController alloc] init] animated:YES];
//                    [weakSelf.sideMenuViewController hideMenuViewController];
                }
                    break;
                default:
                    break;
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kDrawerNotificaiton object:weakSelf userInfo:dic];
        };
    }
    return _drawerView;
}

- (ZYMenuView *)menuView {
    if (!_menuView) {
        _menuView = [[ZYMenuView alloc] initWithFrame:CGRectMake(0, 0, Level*308, HEIGHT)];
        WS(weakSelf)
        _menuView.didSelectRow = ^(NSInteger row) {
            switch (row) {
                case 0: {
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }
                    break;
                case 1: {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
                    break;
                case 2: {
                    NSDictionary *dic = @{@"status":@"two"};
                    [[NSNotificationCenter defaultCenter] postNotificationName:kDrawerNotificaiton object:weakSelf userInfo:dic];
                }
                    break;
                default:
                    break;
            }
        };
    }
    return _menuView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.drawerView.bounds];
        _maskView.hidden = YES;
        _maskView.alpha = 0.1f;
        _maskView.backgroundColor = [UIColor blackColor];
    }
    return _maskView;
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
