//
//  ZYHealthKitManager.h
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/26.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

@interface ZYHealthKitManager : NSObject

@property (nonatomic, strong) HKHealthStore *healthStore;

+ (id)shareManger;
/** 检查是否支持获取健康数据 */
- (void)authorizeHealthKit:(void(^)(BOOL success, NSError  *error))compltion;
/** 读取步数 */
- (void)getStepCount:(void(^)(double value, NSError *error))completion;
/** 获取公里数 */
- (void)getDistance:(void(^)(double value, NSError *error))completion;
/** NSPredicate当天时间段的方法 */
+ (NSPredicate *)predicateForSamplesToday;

@end
