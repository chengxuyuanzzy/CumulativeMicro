//
//  ZYMainModel.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/12.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYMainModel.h"

@implementation ZYMainModel

- (NSArray *)listArray {
    if (!_listArray) {
        _listArray = @[@"轮播图", @"图片处理", @"二维码", @"双tableView", @"健康", @"手势", @"物理仿真"];
    }
    return _listArray;
}

@end
