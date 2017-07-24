//
//  ZYPrompt.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/16.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYPrompt.h"
#import <AVFoundation/AVFoundation.h>

@implementation ZYPrompt

+ (void)soundVendorsWithResource:(NSString *)resource extension:(NSString *)extension {
    SystemSoundID ditaVoice;
    
    // 1. 定义要播放的音频文件的URL
    NSURL *voiceURL = [[NSBundle mainBundle]URLForResource:resource withExtension:extension];
    // 2. 注册音频文件（第一个参数是音频文件的URL 第二个参数是音频文件的SystemSoundID）
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(voiceURL),&ditaVoice);
    // 3. 为crash播放完成绑定回调函数
    //        AudioServicesAddSystemSoundCompletion(ditaVoice,NULL,NULL,completionCallback(ditaVoice),NULL);
    // 4. 播放 ditaVoice 注册的音频 并控制手机震动
    AudioServicesPlayAlertSound(ditaVoice);
    //    AudioServicesPlaySystemSound(ditaVoice);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); // 控制手机振动
}

@end
