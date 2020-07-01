//
//  YJTabBarController.m
//  Reader
//
//  Created by Yang on 2020/6/9.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJTabBarController.h"
#import <Foundation/Foundation.h>
#import "YJHomeViewController.h"
#import "YJShelfViewController.h"
#import "YJAnalysisViewController.h"
#import "YJProfileViewController.h"
#import "UIImage+YJImage.h"
#import "YJNaviagtionController.h"

@interface YJTabBarController () <UITabBarControllerDelegate>

@end

@implementation YJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self setTabBarControllerConfiguration];
    
    //文字颜色
    self.tabBar.tintColor = [UIColor redColor];
    
    self.delegate = self;
}


#pragma mark - 给tabbar图标添加动画
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    
    for (UIView* subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            UIControl *tabbarBtn = (UIControl *)subView;
            [tabbarBtn addTarget:self action:@selector(setAnimationFor:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark - 配置控制器
-(void)setTabBarControllerConfiguration{
    UINavigationController *homeNav = [self setChild:[[YJHomeViewController alloc] init] WithTitle:@"首页" imageName:@"home" selectedImageName:@"home_selected"];
    
    UINavigationController *shelfNav = [self setChild:[[YJShelfViewController alloc] init] WithTitle:@"书架" imageName:@"shelf" selectedImageName:@"shelf_selected"];
    
    UINavigationController *analysisNav = [self setChild:[[YJAnalysisViewController alloc] init] WithTitle:@"分析" imageName:@"analysis" selectedImageName:@"analysis_selected"];
    
    UINavigationController *profileNav = [self setChild:[[YJProfileViewController alloc] init] WithTitle:@"我的" imageName:@"profile" selectedImageName:@"profile_selected"];
    
    
    self.viewControllers = @[homeNav, shelfNav, analysisNav, profileNav];
}

#pragma mark - 初始化子控制器
-(UINavigationController *)setChild:(UIViewController *)childVC WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    YJNaviagtionController *nav = [[YJNaviagtionController alloc] initWithRootViewController:childVC];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage originImageWithName:imageName];
    nav.tabBarItem.selectedImage = [UIImage originImageWithName:selectedImageName];
    return nav;;
}

#pragma mark - tabbar图标动画函数
-(void)setAnimationFor:(UIControl *)tabbarBtn
{
    for (UIImageView *imageView in tabbarBtn.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
            animation.values = @[@0.0, @(-4.15), @(-7.26), @(-9.34), @(-10.37), @(-9.34), @(-7.26), @(-7.26), @0.0, @2.0, @(-2.9), @(-4.94), @(-6.11), @(-6.42), @(-5.86), @(-4.44), @(-2.16), @0.0];
            animation.duration = 0.5;
            animation.calculationMode = kCAAnimationCubic;
            [imageView.layer addAnimation:animation forKey:NULL];
        }
    }
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(YJNaviagtionController *)viewController{
    if (viewController.childViewControllers[0].class != [YJShelfViewController class]) {
        YJNaviagtionController *nav = tabBarController.childViewControllers[1];
        YJShelfViewController *shelfVc = nav.childViewControllers[0];
        [shelfVc cancelPopView];
    }
}

@end
