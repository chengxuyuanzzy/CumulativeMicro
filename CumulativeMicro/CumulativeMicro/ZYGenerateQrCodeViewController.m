//
//  ZYGenerateQrCodeViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/16.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYGenerateQrCodeViewController.h"
#import "ZYQRCode.h"
#import "ZYScanResultViewController.h"

@interface ZYGenerateQrCodeViewController () {
    UIImageView *imageView1;
}

@end

@implementation ZYGenerateQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生成二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self generateQrCode];
    // Do any additional setup after loading the view.
}

- (void)generateQrCode {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 200, 200)];
    imageView.image = [ZYQRCode generatorWithQRCodeData:@"https://www.baidu.com" imageViewWidth:imageView.frame.size.width];
    [self.view addSubview:imageView];
    
    imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 310, 200, 200)];
    imageView1.image = [ZYQRCode generateWithLogoQRCodeData:@"https://www.baidu.com" logo:@"4.jpeg" logoScaleToSuperView:0.2];
    [self.view addSubview:imageView1];
    
    imageView1.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *pressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    pressGes.minimumPressDuration = 0.8;
    [imageView1 addGestureRecognizer:pressGes];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(215, 310, 20, 200)];
    tipLabel.text = @"长按识别图中二维码";
    tipLabel.textColor = [UIColor blackColor];
    tipLabel.font = [UIFont systemFontOfSize:Level*14.f];
    tipLabel.numberOfLines = 0;
    [self.view addSubview:tipLabel];
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [self showHint:@"识别中..."];
        NSString *str = [ZYQRCode scanQRCodeWithPhotoLibraryImage:imageView1.image resource:@"5383" extension:@"mp3"];
        
        [self hidesHUD];
        if (str) {
            ZYScanResultViewController *resultVC = [[ZYScanResultViewController alloc] init];
            resultVC.resultString = str;
            [self.navigationController pushViewController:resultVC animated:YES];
        }else {
            [self showHint:@"未识别..." delay:2.f];
        }
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
