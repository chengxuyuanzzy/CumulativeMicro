//
//  ZYMainViewModel.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/12.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYMainViewModel.h"

@implementation ZYMainViewModel

#pragma - lazyLoad
- (RACSubject *)cellClickSubject {
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}

@end
