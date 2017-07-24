//
//  ZYPrompt.h
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/16.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYPrompt : NSObject


/**
 提示音

 @param resource 名称
 @param extension 类型
 */
+ (void)soundVendorsWithResource:(NSString *)resource extension:(NSString *)extension;

@end
