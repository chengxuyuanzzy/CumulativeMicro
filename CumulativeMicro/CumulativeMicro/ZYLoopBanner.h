//
//  ZYLoopBanner.h
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/12.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYLoopBanner : UIView

@property (nonatomic, copy) NSArray *imageArray;

@property (nonatomic, copy) void (^clickAction) (NSInteger curIndex);

- (instancetype)initWithFrame:(CGRect)frame scrollDuration:(NSTimeInterval)duration;

@end
