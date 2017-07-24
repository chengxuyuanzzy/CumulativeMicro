//
//  ZYCalculatorHelper.h
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/9.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCalculatorHelper : NSObject

@property (nonatomic, assign) float sum;
@property (nonatomic, assign) float number1;
@property (nonatomic, assign) float number2;

+ (id)shareManager;

- (NSString *)calculatorResult:(NSString *)type number:(NSString *)number;

@end
