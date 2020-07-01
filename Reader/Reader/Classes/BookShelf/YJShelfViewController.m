//
//  YJShelfViewController.m
//  Reader
//
//  Created by Yang on 2020/6/9.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJShelfViewController.h"
#import "UIBarButtonItem+YJBarButtonItem.h"
#import "YJPulsView.h"
#import "YJNaviagtionController.h"
#import "YJShelfCollectionView.h"
#import "YJShelflItem.h"
#import "YJReadViewController.h"
#import "YJReaderAnimation.h"

@interface YJShelfViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) YJShelfCollectionView * collectionView;
@end

@implementation YJShelfViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    [self setUpNavigation];
    
    __weak typeof(self) weakSelf = self;
    YJShelfCollectionView *collectionView = [[YJShelfCollectionView alloc] initCollectionViewWith:CGRectMake(0, YJNavBarHeight, YJScreenWidth, self.view.frame.size.height - YJNavBarHeight - YJTabBarHeight) dataArr:[self configurationDataArray] didSelected:^(YJShelfCollectionView * collectionView, NSIndexPath* indexPath) {
        weakSelf.indexPath = indexPath;
        weakSelf.collectionView = collectionView;
        [weakSelf.navigationController pushViewController:[[YJReadViewController alloc] init] animated:YES];
    }];
    [self.view addSubview:collectionView];
}

-(void)setUpNavigation{
    self.navigationItem.title = @"我的书架";
    UIBarButtonItem *searchItem = [UIBarButtonItem btnWithImageName:@"search" target:self action:@selector(searchBtnDidClicked)];
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:NULL action:NULL];
    spaceItem.width = 15;
    
    UIBarButtonItem *pulsItem = [UIBarButtonItem btnWithImageName:@"puls" target:self action:@selector(pulsBtnDidClicked)];
    
    self.navigationItem.rightBarButtonItems = @[spaceItem, pulsItem, spaceItem, searchItem];
}

-(NSArray *)configurationDataArray{
    NSArray * arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shelfCollectionViewList" ofType:@".plist"]];
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        YJShelflItem * item = [[YJShelflItem alloc] initWithDict:dict];
        [temp addObject:item];
    }
    arr = temp;
    return arr;
}

-(void)searchBtnDidClicked
{
    NSLog(@"%s",__func__);

}
-(void)pulsBtnDidClicked
{
    NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pulsViewList" ofType:@".plist"]];
    [YJPulsView initWithFrame:CGRectMake(self.view.bounds.size.width - 100, YJNavBarHeight, 150, 200) datas:arr action:^(NSString * title) {
        NSLog(@"点击了---%@",title);
    }];
}
-(void)cancelPopView{
    [YJPulsView cancelPopView];
}


#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    
    YJReaderAnimation * reader = [[YJReaderAnimation alloc] initWithindexPath:_indexPath];
    reader.pushDelegate = _collectionView;
    if (operation == UINavigationControllerOperationPush) {
        reader.isPush = YES;
        return reader;
    }else{
        reader.isPush = NO;
        return reader;
        return nil;
    }
}
@end
