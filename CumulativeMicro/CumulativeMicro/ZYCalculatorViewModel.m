//
//  ZYCalculatorViewModel.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/9.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYCalculatorViewModel.h"
#import "ZYCalculatorModel.h"
#import "ZYCalculatorHelper.h"

@interface ZYCalculatorViewModel ()

@property (nonatomic, strong) ZYCalculatorModel *model;

@end

@implementation ZYCalculatorViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initViewModel];
    }
    return self;
}

- (void)initViewModel {
    //进行消息接收
    @weakify(self);
    [self.keyButtonClickCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        if ([x isEqualToString:@"AC"]) {
            self.model.screenString = @"0";
            self.model.screenNum = @"0";
            [[ZYCalculatorHelper shareManager] setSum:0];
            [[ZYCalculatorHelper shareManager] setNumber1:0];
            [[ZYCalculatorHelper shareManager] setNumber2:0];
            [[ZYCalculatorHelper shareManager] calculatorResult:x number:self.model.screenString];
        }else if ([x isEqualToString:@"+/_"]) {
            
        }else if ([x isEqualToString:@"%"]) {
            [self calculatorSum:x];
        }else if ([x isEqualToString:@"÷"]) {
            [self calculatorSum:x];
        }else if ([x isEqualToString:@"×"]) {
            [self calculatorSum:x];
        }else if ([x isEqualToString:@"-"]) {
            [self calculatorSum:x];
        }else if ([x isEqualToString:@"+"]) {
            [self calculatorSum:x];
        }else if ([x isEqualToString:@"="]) {
            [self calculatorSum:x];
        }else {
            //判断是否右滑
            if ([x isEqualToString:@"right"]) {
                self.model.screenNum = [self.model.screenNum substringToIndex:self.model.screenNum.length-1];
                self.model.screenString = self.model.screenNum;
                if ([self.model.screenNum isEqualToString:@""]) {
                    self.model.screenNum = @"0";
                    self.model.screenString = @"";
                }
            }else {
                if ([self.model.screenString isEqualToString:@"0"]) {
                    self.model.screenString = @"";
                }
                self.model.screenNum = [self.model.screenString stringByAppendingFormat:@"%@", x];
                self.model.screenString = self.model.screenNum;
            }
        }
        [self.clickSubject sendNext:self.model.screenNum];
    }];
}

- (void)calculatorSum:(NSString *)x {
    NSString *str = [[ZYCalculatorHelper shareManager] calculatorResult:x number:self.model.screenString];
    self.model.screenString = @"0";
    //记录屏幕上的数字
    self.model.screenNum = str;
}
#pragma - lazyLoad
- (RACCommand *)keyButtonClickCommand {
    if (!_keyButtonClickCommand) {
        _keyButtonClickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //接收键盘并发送
                [subscriber sendNext:input];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _keyButtonClickCommand;
}

- (ZYCalculatorModel *)model {
    if (!_model) {
        _model = [[ZYCalculatorModel alloc] init];
        _model.screenString = @"";
        _model.screenNum = @"0";
    }
    return _model;
}

- (RACSubject *)clickSubject {
    if (!_clickSubject) {
        _clickSubject = [RACSubject subject];
    }
    return _clickSubject;
}

@end
