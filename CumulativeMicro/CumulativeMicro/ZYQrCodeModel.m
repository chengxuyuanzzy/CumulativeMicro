//
//  ZYQrCodeModel.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/15.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYQrCodeModel.h"

@implementation ZYQrCodeModel

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"扫描二维码", @"生成二维码"];
    }
    return _dataArray;
}

@end
