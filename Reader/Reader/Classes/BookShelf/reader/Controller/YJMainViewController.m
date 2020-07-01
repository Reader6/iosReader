//
//  YJMainViewController.m
//  Reader
//
//  Created by Yang on 2020/6/25.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJMainViewController.h"
#import "YJReaderEasyPopView.h"
#import "YJDisplayViewController.h"
#import "YJReadItem.h"
#import "YJChapterItem.h"

@interface YJMainViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource, YJDisplayViewControllerDelegate>
{
    NSUInteger _chapter;
    NSUInteger _page;
    NSUInteger _chapterChange;
    NSUInteger _pageChange;
}
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, strong) UIPageViewController * pageVC;
@property (nonatomic, strong) YJDisplayViewController * dispalyVC;
@property (nonatomic, strong) YJReadItem * model;


@end

@implementation YJMainViewController

- (instancetype)initWithModel:(YJReadItem *)model{
    self = [super init];
    if (self) {
        self.model = model;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPopView) name:Notification_showPopView object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isHiddenStatusBar) name:Notification_removePopView object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(muluBtnClick) name:Notification_showLeftVc object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpTocharpter:) name:Notification_hiddenLeftVc object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preBtnClick:) name:Notification_preChapter object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextBtnClick:) name:Notification_NextChapter object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configChange) name:Notification_configChange object:nil];
        
    }
    return self;
}


-(void)configChange{
    [_pageVC setViewControllers:@[[self readViewWithChapter:_chapter page:_page]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

-(void)preBtnClick:(NSNotification *)note{
    
    __weak UISlider *slide = [note object];
    _chapter = _chapter - 1;
    _page = 0;
    [_pageVC setViewControllers:@[[self readViewWithChapter:_chapter page:_page]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    if (_chapter == 0) {
        slide.value = 0.0;
    }else{
        slide.value = (1.0 / (_model.chapters.count - 1)) * _chapter;
    }
}

-(void)nextBtnClick:(NSNotification *)note{
     __weak UISlider *slide = [note object];
    _chapter = _chapter + 1;
    _page = 0;
    [_pageVC setViewControllers:@[[self readViewWithChapter:_chapter page:_page]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    if (_chapter == _model.chapters.count - 1) {
        slide.value = 1.0;
    }else{
        slide.value = (1.0 / (_model.chapters.count - 1)) * _chapter;
    }
}

-(void)jumpTocharpter:(NSNotification *)note{
    NSUInteger chapter = [[note object] integerValue];
    _chapter = chapter;
    _page = 0;
    [_pageVC setViewControllers:@[[self readViewWithChapter:_chapter page:_page]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}
-(void)showPopView{
    [self isHiddenStatusBar];
    [YJReaderEasyPopView readerEasyPopView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _statusBarHidden = YES;
    [self addChildViewController:self.pageViewController];
    _chapter = 0;
    _page = 0;
    [_pageVC setViewControllers:@[[self readViewWithChapter:_chapter page:_page]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(UIPageViewController *)pageViewController
{
    if (!_pageVC) {
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
        [self.view addSubview:_pageVC.view];
    }
    return _pageVC;
}
-(YJDisplayViewController *)readViewWithChapter:(NSUInteger)chapter page:(NSUInteger)page{
    _dispalyVC = [[YJDisplayViewController alloc] init];
    _dispalyVC.content =  [_model.chapters[chapter] stringOfPage:page];
    _dispalyVC.delegate = self;
    return _dispalyVC;
}

-(void)readViewEndEdit:(YJDisplayViewController *)readView
{
}
-(void)readViewEditeding:(YJDisplayViewController *)readView
{
}


///返回上一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{

    _pageChange = _page;
    _chapterChange = _chapter;

    //第一张第一页
    if (_chapterChange == 0 && _pageChange == 0) {
        return nil;
    }
    //某章第一页
    if (_pageChange == 0) {
        //返回上一章
        _chapterChange--;

        //上一章最后一页
        _pageChange = _model.chapters[_chapterChange].pageCount - 1;
    }
    else{
        _pageChange--;
    }

    return [self readViewWithChapter:_chapterChange page:_pageChange];

}


///下一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{

    _pageChange = _page;
    _chapterChange = _chapter;

    //本书的最后一章最后一页
    if (_chapterChange == _model.chapters.count - 1 && _pageChange == _model.chapters.lastObject.pageCount - 1){
        return nil;
    }
    //某章的最后一页
    if (_pageChange == _model.chapters[_chapterChange].pageCount - 1) {
        //下一章
        _chapterChange++;
        //页数归0
        _pageChange = 0;
    }
    else{
        //直接下一页
        _pageChange++;
    }
    return [self readViewWithChapter:_chapterChange page:_pageChange];
}
//动画即将开始
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    _chapter = _chapterChange;
    _page = _pageChange;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIBarStyleBlack;
    [self hiddenNavBarAndTabbar];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIBarStyleDefault;
    [self hiddenNavBarAndTabbar];
}

-(void)hiddenNavBarAndTabbar{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

///实现/隐藏状态栏
-(void)isHiddenStatusBar{
    _statusBarHidden = !_statusBarHidden;
    [UIApplication sharedApplication].statusBarHidden = _statusBarHidden;
    [self.navigationController setNavigationBarHidden:_statusBarHidden animated:YES];
}


-(void)muluBtnClick{
    [YJReaderEasyPopView removeEasyPopViewWithAnimation:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_upDateChapter object:_model.chapters];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
