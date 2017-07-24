//
//  ZYHungryModel.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/21.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYHungryModel.h"

@implementation ZYHungryModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"data" : Data.class,
             };
}

@end

@implementation Data

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"dataArray" : DataArray.class,
             };
}

@end

@implementation DataArray


@end
