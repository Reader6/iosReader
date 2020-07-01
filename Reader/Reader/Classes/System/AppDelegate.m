//
//  AppDelegate.m
//  Reader
//
//  Created by Yang on 2020/6/8.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "AppDelegate.h"
#import "YJTabBarController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    self.window.rootViewController = [[YJTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}



@end
