//
//  ZYHungryViewModel.h
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/21.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYHungryModel.h"

@interface ZYHungryViewModel : NSObject

@property (nonatomic, strong) RACSubject *scrollEnableSubject;

- (void)loadDataWithSuccess:(void (^)(ZYHungryModel *))success failure:(void (^)())failure;

@end
