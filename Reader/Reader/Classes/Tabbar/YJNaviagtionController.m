//
//  YJNaviagtionController.m
//  Reader
//
//  Created by Yang on 2020/6/19.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJNaviagtionController.h"
#import "UIBarButtonItem+YJBarButtonItem.h"
@interface YJNaviagtionController ()

@end
//https://www.cnblogs.com/mukekeheart/p/8194527.html
@implementation YJNaviagtionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem btnWithImageName:@"goBack" target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
