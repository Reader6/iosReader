//
//  YJDetailViewController.m
//  Reader
//
//  Created by Yang on 2020/6/17.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJDetailViewController.h"

#import "YJTagNavView.h"
#import "YJDetailScrollView.h"


@interface YJDetailViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) id<UIGestureRecognizerDelegate> delegate;
@property (nonatomic, strong) NSString *controlName;
@property (nonatomic, strong) YJTagNavView *tagNav;
@property (nonatomic, strong) YJDetailScrollView * scrollView;
@end

@implementation YJDetailViewController
-(instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.controlName = title;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //导航条设置
    self.navigationItem.title = _controlName;
    
    
    NSArray *arr = @[@"热读榜", @"新书榜", @"口碑榜", @"影视原著"];
    self.tagNav = [[YJTagNavView alloc] initWithFrame:CGRectMake(0, YJNavBarHeight, YJScreenWidth, 50) titles:arr];
    [self.view addSubview:_tagNav];
    
    self.scrollView = [[YJDetailScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tagNav.frame), YJScreenWidth, self.view.frame.size.height - CGRectGetMaxY(_tagNav.frame) - YJTabBarHeight)];
    _tagNav.delegate = _scrollView;
    _scrollView.tagView = _tagNav;
    [self.view addSubview:_scrollView];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.navigationController.viewControllers.count > 1) {
          // 记录系统返回手势的代理
        _delegate = self.navigationController.interactivePopGestureRecognizer.delegate;
          // 设置系统返回手势的代理为当前控制器
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
     // 设置系统返回手势的代理为我们刚进入控制器的时候记录的系统的返回手势代理
    self.navigationController.interactivePopGestureRecognizer.delegate = _delegate;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
        return self.navigationController.childViewControllers.count > 1;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}
@end
