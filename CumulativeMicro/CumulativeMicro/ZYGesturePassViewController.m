//
//  ZYGesturePassViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/7/4.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYGesturePassViewController.h"

@interface ZYGesturePassViewController () <UITableViewDelegate, UITableViewDataSource> {
    UIView *bottomView;
    UIPanGestureRecognizer *panGes;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZYGesturePassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势传递";
    self.view.backgroundColor = [UIColor whiteColor];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Verticl*100, WIDTH, HEIGHT-Verticl*100)];
    bottomView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:bottomView];
    
    panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [bottomView addGestureRecognizer:panGes];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, bottomView.kHeight-50) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.bounces = NO;
    self.tableView.sectionFooterHeight = 0.001;
    [bottomView addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Verticl*40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID1"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"测试%ld", indexPath.row];
    return cell;
}

- (void)panAction:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint newCenter = CGPointMake(recognizer.view.center.x+ translation.x,
                                    recognizer.view.center.y + translation.y);
    CGPoint tran = [recognizer locationInView:self.view];
    
    //    限制屏幕范围：
    newCenter.y = MAX(recognizer.view.frame.size.height/2+Verticl*30, newCenter.y);
    newCenter.y = MIN(self.view.frame.size.height - recognizer.view.frame.size.height/2+64, newCenter.y);
    newCenter.x = MAX(recognizer.view.frame.size.width/2, newCenter.x);
    newCenter.x = MIN(self.view.frame.size.width - recognizer.view.frame.size.width/2,newCenter.x);
    NSLog(@"%f", newCenter.y);
    if (newCenter.y - Verticl*313.5 < 0.1) {
        CGFloat trans = recognizer.view.center.y-tran.y;
        if (trans < 0) {
            trans = 0;
        }
        self.tableView.contentOffset = CGPointMake(0, trans);
        
        if (self.tableView.contentOffset.y > 0) {
            self.tableView.scrollEnabled = YES;
        }else {
            recognizer.view.center = newCenter;
            self.tableView.scrollEnabled = NO;
        }
    }else {
        if (self.tableView.contentOffset.y > 0) {
            CGFloat trans = recognizer.view.center.y-tran.y;
            if (trans < 0) {
                trans = 0;
            }
            self.tableView.contentOffset = CGPointMake(0, trans);
        }else {
            recognizer.view.center = newCenter;
            self.tableView.scrollEnabled = NO;
        }
    }
    [recognizer setTranslation:CGPointZero inView:self.view];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.tableView.contentOffset.y == 0) {
        self.tableView.scrollEnabled = NO;
    }
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
