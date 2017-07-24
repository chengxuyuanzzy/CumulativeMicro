//
//  ZYCalculatorHelper.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/9.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYCalculatorHelper.h"

@interface ZYCalculatorHelper ()

//上一个符号
@property (nonatomic, strong) NSString *onKeyType;
//符号
@property (nonatomic, strong) NSString *keyType;
//等号存储
@property (nonatomic, strong) NSString *equalType;

@end

@implementation ZYCalculatorHelper

+ (id)shareManager {
    static ZYCalculatorHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[ZYCalculatorHelper alloc] init];
    });
    return helper;
}

- (NSString *)calculatorResult:(NSString *)type number:(NSString *)number {
    self.number2 = [number floatValue];
    if ([type isEqualToString:@"AC"]) {
        
    }else if ([type isEqualToString:@"+/_"]) {
        
    }else if ([type isEqualToString:@"%"]) {
        self.keyType = type;
        self.sum = self.number2/100;
    }else if ([type isEqualToString:@"÷"]) {
        self.keyType = type;
        if (self.onKeyType == nil || [self.onKeyType isEqualToString:@"AC"] || [self.keyType isEqualToString:self.onKeyType]) {
            [self div];
        }else {
            [self equal:self.onKeyType];
        }
    }else if ([type isEqualToString:@"×"]) {
        self.keyType = type;
        if (self.onKeyType == nil || [self.onKeyType isEqualToString:@"AC"] || [self.keyType isEqualToString:self.onKeyType]) {
            [self mul];
        }else {
            [self equal:self.onKeyType];
        }
    }else if ([type isEqualToString:@"-"]) {
        self.keyType = type;
        if (self.onKeyType == nil || [self.onKeyType isEqualToString:@"AC"] || [self.keyType isEqualToString:self.onKeyType]) {
            [self sub];
        }else {
            [self equal:self.onKeyType];
        }
    }else if ([type isEqualToString:@"+"]) {
        self.keyType = type;
        if (self.onKeyType == nil || [self.onKeyType isEqualToString:@"AC"] || [self.keyType isEqualToString:self.onKeyType]) {
            [self add];
        }else {
            [self equal:self.onKeyType];
        }
    }else if ([type isEqualToString:@"="]) {
        self.equalType = @"=";
        [self equal:self.keyType];
    }else {
        
    }
    self.onKeyType = type;
    return [self stringDisposeWithFloat:self.sum];;
}

/**
 计算= 号方法
 @param type 存储的运算符
 */
- (void)equal:(NSString *)type {
    if ([type isEqualToString:@"%"]) {
        
    }else if ([type isEqualToString:@"÷"]) {
        [self div];
    }else if ([type isEqualToString:@"×"]) {
        [self mul];
    }else if ([type isEqualToString:@"-"]) {
        [self sub];
    }else if ([type isEqualToString:@"+"]) {
        [self add];
    }
//    self.keyType = type;
}

//浮点数处理并去掉多余的0
- (NSString *)stringDisposeWithFloat:(float)floatValue {
    NSString *str = [NSString stringWithFormat:@"%f",floatValue];
    long len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        //s.substring(0, len - i - 1);
        return [str substringToIndex:[str length]-1];
    }
    else
    {
        return str;
    }
}
#pragma - 加法
- (void)add {
    self.sum = self.number1 + self.number2;
    self.number1 = self.sum;
}
#pragma - 减法
- (void)sub {
    if (self.sum == 0) {
        self.sum = self.number2;
    }else {
        self.sum = self.sum - self.number2;
        self.number1 = self.sum;
    }
}
#pragma - 乘法
- (void)mul {
    if (self.sum == 0) {
        self.sum = self.number2;
    }else {
        self.sum *= self.number2;
    }
}
#pragma - 除法
- (void)div {
    if (self.sum == 0) {
        self.sum = self.number2;
    }else {
        self.sum = self.sum / self.number2;
    }
}

- (BOOL)isequalClick {
    if ([self.equalType isEqualToString:@"="]) {
        return YES;
    }else {
        return NO;
    }
}

@end
