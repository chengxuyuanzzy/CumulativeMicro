//
//  CAShapeLayer+ViewMask.h
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/19.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAShapeLayer (ViewMask)

+ (instancetype)createLanguageMaskLayerWithView:(UIView *)view;

@end
