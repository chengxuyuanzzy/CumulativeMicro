//
//  AppDelegate.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/8.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "AppDelegate.h"
#import "ZYNavViewController.h"
#import "ZYCalculatorViewController.h"
#import "ZYPictureViewController.h"
#import "ZYHeaderTensileViewController.h"
#import "ZYDrawerViewController.h"
#import <MMDrawerController/MMDrawerController.h>
#import <MMDrawerController/MMDrawerVisualState.h>
#import <RESideMenu/RESideMenu.h>

@interface AppDelegate ()

@property (nonatomic, strong) MMDrawerController *drawerController;

@end

@implementation AppDelegate

- (void)notification:(NSNotification *)info {
    NSDictionary *dic = info.userInfo;
    if ([dic[@"status"] isEqualToString:@"two"]) {
        
        UIViewController *centerVC = [[ZYHeaderTensileViewController alloc] init];
        UIViewController *leftVC = [[ZYPictureViewController alloc] init];
        UIViewController *rightVC = [[ZYDrawerViewController alloc] init];
        
        UINavigationController *centertNav = [[ZYNavViewController alloc] initWithRootViewController:centerVC];
        UINavigationController *leftNav = [[ZYNavViewController alloc] initWithRootViewController:leftVC];
        UINavigationController *rightNav = [[ZYNavViewController alloc] initWithRootViewController:rightVC];
        
        self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:centertNav leftDrawerViewController:leftNav rightDrawerViewController:rightNav];
        self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
        self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
        self.drawerController.maximumLeftDrawerWidth = Level*300;
        self.drawerController.maximumRightDrawerWidth = Level*300;
        
        [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
            MMDrawerControllerDrawerVisualStateBlock block;
            block = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.f];
            if (block) {
                block(drawerController, drawerSide, percentVisible);
            }
        }];
        
        self.window.rootViewController = self.drawerController;
    }else if ([dic[@"status"] isEqualToString:@"one"]){
        ZYCalculatorViewController *calculatorVC = [[ZYCalculatorViewController alloc] init];
        ZYNavViewController *nav = [[ZYNavViewController alloc] initWithRootViewController:calculatorVC];
        self.window.rootViewController = nav;
    }else {
        ZYHeaderTensileViewController *headerVC = [[ZYHeaderTensileViewController alloc] init];
        ZYNavViewController *nav = [[ZYNavViewController alloc] initWithRootViewController:headerVC];
        
        ZYPictureViewController *picVC = [[ZYPictureViewController alloc] init];
        ZYDrawerViewController *drawerVC = [[ZYDrawerViewController alloc] init];
        RESideMenu *sideMenuVC = [[RESideMenu alloc] initWithContentViewController:nav leftMenuViewController:picVC rightMenuViewController:drawerVC];
        sideMenuVC.backgroundImage = [UIImage imageNamed:@"6.jpeg"];
        sideMenuVC.menuPreferredStatusBarStyle = 1;
//        sideMenuVC.delegate = self;
        sideMenuVC.contentViewShadowColor = [UIColor blackColor];
        sideMenuVC.contentViewShadowOffset = CGSizeMake(0, 0);
        sideMenuVC.contentViewShadowOpacity = 0.6;
        sideMenuVC.contentViewShadowRadius = 12;
        sideMenuVC.contentViewShadowEnabled = YES;
        self.window.rootViewController = sideMenuVC;
        
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ZYCalculatorViewController *calculatorVC = [[ZYCalculatorViewController alloc] init];
    ZYNavViewController *nav = [[ZYNavViewController alloc] initWithRootViewController:calculatorVC];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:kDrawerNotificaiton object:nil];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
