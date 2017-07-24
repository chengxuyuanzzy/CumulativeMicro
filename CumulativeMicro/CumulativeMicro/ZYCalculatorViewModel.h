//
//  ZYCalculatorViewModel.h
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/9.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCalculatorViewModel : NSObject

@property (nonatomic, strong) RACCommand *keyButtonClickCommand;

@property (nonatomic, strong) RACSubject *clickSubject;

@end
