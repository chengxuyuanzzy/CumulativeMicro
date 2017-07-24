//
//  ZYHungryModel.h
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/21.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataArray : NSObject

@property (nonatomic, assign) NSInteger numCount;
@property (nonatomic, copy) NSString *name;

@end

@interface Data : NSObject

@property (nonatomic, strong) NSArray<DataArray *> *dataArray;

@property (nonatomic, copy) NSString *storeName;

@end

@interface ZYHungryModel : NSObject

@property (nonatomic, strong) NSArray<Data *> *data;

@end
