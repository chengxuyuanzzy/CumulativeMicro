//
//  UIView+Frame.m
//  Tools
//
//  Created by 朱忠阳 on 2017/5/12.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setKWidth:(CGFloat)kWidth {
    CGRect frame = self.frame;
    frame.size.width = kWidth;
    self.frame = frame;
}

- (CGFloat)kWidth {
    return self.frame.size.width;
}

- (void)setKHeight:(CGFloat)kHeight {
    CGRect frame = self.frame;
    frame.size.height = kHeight;
    self.frame = frame;
}

- (CGFloat)kHeight {
    return self.frame.size.height;
}

@end
