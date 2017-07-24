//
//  ZYQRCode.h
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/16.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYQRCode : NSObject


/**
 扫描照片二维码

 @param image image
 @return 扫描出的信息
 */
+ (NSString *)scanQRCodeWithPhotoLibraryImage:(UIImage *)image resource:(NSString *)resource extension:(NSString *)extension;
/** 生成二维码 */
+ (UIImage *)generatorWithQRCodeData:(NSString *)data imageViewWidth:(CGFloat)imageViewWidth;

/**
 生成有logo的二维码

 @param data 内容
 @param logo 图片
 @param logoScaleToSuperView 相对于父视图的缩放比 0-1 ； 0不显示  1与父视图大小相同
 @return UImage
 */
+ (UIImage *)generateWithLogoQRCodeData:(NSString *)data logo:(NSString *)logo logoScaleToSuperView:(CGFloat)logoScaleToSuperView;

@end
