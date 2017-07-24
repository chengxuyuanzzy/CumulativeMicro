//
//  ZYHungryViewModel.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/21.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYHungryViewModel.h"
#import <YYModel/YYModel.h>

@implementation ZYHungryViewModel

- (void)loadDataWithSuccess:(void (^)(ZYHungryModel *))success failure:(void (^)())failure {
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *nameArray = @[@"热销", @"配料", @"汉堡类", @"鸡肉卷", @"套餐类", @"小吃类", @"全鸡", @"冷饮", @"热饮"];
    NSArray *array1 = @[@"香辣鸡腿堡", @"蜜汁手扒鸡", @"脆皮炸鸡"];
    NSArray *array2 = @[@"番茄酱", @"孜然粉"];
    NSArray *array3 = @[@"香辣鸡腿堡", @"香脆鸡腿堡", @"奥尔良鸡腿堡", @"巨无霸", @"至珍鲜虾堡", @"蟹黄堡", @"虾堡", @"超级牛肉堡", @"牛肉堡", @"鳕鱼堡"];
    NSArray *array4 = @[@"墨西哥鸡肉卷", @"北京鸡肉卷"];
    NSArray *array5 = @[@"两个香辣鸡腿堡+中杯可乐", @"香辣鸡腿堡+上校鸡块+香辣鸡翅+中可", @"3个香辣鸡腿堡"];
    NSArray *array6 = @[@"香辣鸡翅", @"鸡腿", @"奥尔良烤翅", @"金牌烤翅", @"黄金小鸡腿", @"鸡米花", @"上校鸡块", @"辣子鸡块", @"薯条", @"大鸡排", @"蝴蝶虾", @"脆皮香蕉"];
    NSArray *array7 = @[@"蜜汁手扒鸡", @"脆皮炸鸡"];
    NSArray *array8 = @[@"百事可乐", @"美年达橙味", @"七喜", @"酸梅汤", @"草莓奶茶", @"草莓汁", @"哈密瓜奶茶", @"芒果汁", @"橙汁", @"香芋奶茶"];
    NSArray *array9 = @[@"牛奶", @"哈密瓜奶茶", @"草莓汁", @"草莓奶茶", @"香芋奶茶", @"芒果汁", @"橙汁"];
    
    NSMutableArray *mArray1 = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<array1.count; i++) {
        NSDictionary *ddd = @{@"name":array1[i]};
        [mArray1 addObject:ddd];
    }
    
    NSMutableArray *mArray2 = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<array2.count; i++) {
        NSDictionary *ddd = @{@"name":array2[i]};
        [mArray2 addObject:ddd];
    }
    
    NSMutableArray *mArray3 = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<array3.count; i++) {
        NSDictionary *ddd = @{@"name":array3[i]};
        [mArray3 addObject:ddd];
    }
    
    NSMutableArray *mArray4 = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<array4.count; i++) {
        NSDictionary *ddd = @{@"name":array4[i]};
        [mArray4 addObject:ddd];
    }
    
    NSMutableArray *mArray5 = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<array5.count; i++) {
        NSDictionary *ddd = @{@"name":array5[i]};
        [mArray5 addObject:ddd];
    }
    
    NSMutableArray *mArray6 = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<array6.count; i++) {
        NSDictionary *ddd = @{@"name":array6[i]};
        [mArray6 addObject:ddd];
    }
    
    NSMutableArray *mArray7 = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<array7.count; i++) {
        NSDictionary *ddd = @{@"name":array7[i]};
        [mArray7 addObject:ddd];
    }
    
    NSMutableArray *mArray8 = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<array8.count; i++) {
        NSDictionary *ddd = @{@"name":array8[i]};
        [mArray8 addObject:ddd];
    }
    
    NSMutableArray *mArray9 = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<array9.count; i++) {
        NSDictionary *ddd = @{@"name":array9[i]};
        [mArray9 addObject:ddd];
    }
    
    for (int i=0; i<nameArray.count; i++) {
        NSDictionary *dic;
        switch (i) {
            case 0: {
                dic = @{@"storeName":nameArray[i], @"dataArray":mArray1};
            }
                break;
            case 1: {
                dic = @{@"storeName":nameArray[i], @"dataArray":mArray2};
            }
                break;
            case 2: {
                dic = @{@"storeName":nameArray[i], @"dataArray":mArray3};
            }
                break;
            case 3: {
                dic = @{@"storeName":nameArray[i], @"dataArray":mArray4};
            }
                break;
            case 4: {
                dic = @{@"storeName":nameArray[i], @"dataArray":mArray5};
            }
                break;
            case 5: {
                dic = @{@"storeName":nameArray[i], @"dataArray":mArray6};
            }
                break;
            case 6: {
                dic = @{@"storeName":nameArray[i], @"dataArray":mArray7};
            }
                break;
            case 7: {
                dic = @{@"storeName":nameArray[i], @"dataArray":mArray8};
            }
                break;
            case 8: {
                dic = @{@"storeName":nameArray[i], @"dataArray":mArray9};
            }
                break;
            default:
                break;
        }
        [dataArray addObject:dic];
    }
    NSDictionary *dict = @{@"data":dataArray};
    ZYHungryModel *model = [ZYHungryModel yy_modelWithDictionary:dict];
    success(model);
}

- (RACSubject *)scrollEnableSubject {
    if (!_scrollEnableSubject) {
        _scrollEnableSubject = [RACSubject subject];
    }
    return _scrollEnableSubject;
}

@end
