//
//  UIView+CornerRadius.h
//  GestureRecognizerTest
//
//  Created by 朱忠阳 on 2017/3/21.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)

+ (UIView *)clipCornerWithView:(UIView *)originView
                    andTopLeft:(BOOL)topLeft
                   andTopRight:(BOOL)topRight
                 andBottomLeft:(BOOL)bottomLeft
                andBottomRight:(BOOL)bottomRight
                 andCGsizeMake:(CGSize)CGSizeMake;

@end
