//
//  ZYDrawerView.h
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/16.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYDrawerView : UIView

@property (nonatomic, strong) void (^didSelectRow)(NSInteger row);

@end
