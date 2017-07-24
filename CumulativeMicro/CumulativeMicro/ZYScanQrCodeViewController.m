//
//  ZYScanQrCodeViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/15.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYScanQrCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZYScanResultViewController.h"
#import "ZYPrompt.h"
#import "ZYQRCode.h"

#define kTOP Verticl*100
#define kLEFT (WIDTH-(Level*260))/2

#define kScanRect CGRectMake(kLEFT, kTOP, (Level*260), (Level*260))

@interface ZYScanQrCodeViewController () <AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NSTimer *timer;
    CAShapeLayer *cropLayer;
    //是否到底部了
    BOOL upOrdown;
    NSInteger num;
}

@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;

@property (nonatomic, strong) UIImageView *lineImageView;

@end

@implementation ZYScanQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showHint:@"加载中..." delay:0];
    
    [self performSelector:@selector(setupCamera) withObject:nil afterDelay:0.3f];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"二维码/条码";
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClcik)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    // Do any additional setup after loading the view.
}
- (void)initView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:kScanRect];
    imageView.image = [UIImage imageNamed:@"pick_bg.png"];
    [self.view addSubview:imageView];
    
    self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kLEFT, kTOP+10, Level*260, 2)];
    self.lineImageView.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:self.lineImageView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLEFT, kTOP + (Level*260) + Verticl * 10, Level*260, Verticl*30)];
    tipLabel.text = @"将二维码／条形码放入框内，即可自动扫描";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont systemFontOfSize:Level*13.f];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    
    upOrdown = NO;
    num = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animationTimer) userInfo:nil repeats:YES];
}
- (void)animationTimer {
    if (upOrdown) {
        num --;
        if (num == 0) {
            upOrdown = NO;
        }
    }else {
        num ++;
        if (2*num == 230) {
            upOrdown = YES;
        }
    }
    self.lineImageView.y = kTOP+10+2*num;
}
- (void)setCropRect:(CGRect)cropRect {
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);
    
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6f];
    
    [cropLayer setNeedsDisplay];
    
    [self.view.layer addSublayer:cropLayer];
}

- (void)setupCamera {
    //Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!_device) {
        AlertView(@"设备没有摄像头");
        [self hidesHUD];
        return;
    }
    //Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    //Output
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    [_output setRectOfInterest:CGRectMake(0.05, 0.2, 0.7, 0.6)];
    //session
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input]) {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output]) {
        [_session addOutput:self.output];
    }
    //条码类型 avmetadataObjectTypeORCode
    [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, nil]];
    //preview
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    //start
    [_session startRunning];
    
    [self initView];
    [self setCropRect:kScanRect];
    [self hidesHUD];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue;
    if ([metadataObjects count] > 0) {
        //停止扫描
        [_session stopRunning];
        [timer setFireDate:[NSDate distantFuture]];
        
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        [ZYPrompt soundVendorsWithResource:@"5383" extension:@"mp3"];
        
        ZYScanResultViewController *resultVC = [[ZYScanResultViewController alloc] init];
        resultVC.resultString = stringValue;
        [self.navigationController pushViewController:resultVC animated:YES];
    }else {
        [self.view makeToast:@"没有扫描信息"];
        return;
    }
}
#pragma - 相册按钮点击事件
- (void)rightBarItemClcik {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self showHint:@"处理中..."];
    [self dismissViewControllerAnimated:YES completion:^{
        [self scanQRCodeFromPhtosInTheAlbum:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scanQRCodeFromPhtosInTheAlbum:(UIImage *)image {
    NSString *str = [ZYQRCode scanQRCodeWithPhotoLibraryImage:image resource:@"5383" extension:@"mp3"];
    [self hidesHUD];
    if (str) {
        ZYScanResultViewController *resultVC = [[ZYScanResultViewController alloc] init];
        resultVC.resultString = str;
        [self.navigationController pushViewController:resultVC animated:YES];
    }else {
        [self showHint:@"未识别..." delay:2.f];
    }
}

- (void)dealloc {
    [timer invalidate];
    timer = nil;
    [_session stopRunning];
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
