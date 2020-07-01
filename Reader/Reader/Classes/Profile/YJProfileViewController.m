//
//  YJProfileViewController.m
//  Reader
//
//  Created by Yang on 2020/6/9.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJProfileViewController.h"
#import "UIBarButtonItem+YJBarButtonItem.h"
#import "YJSettingTableViewController.h"
#import "YJUserMessageView.h"
#import "YJProfileCollectionViewCell.h"


@interface YJProfileViewController ()<UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, copy) NSArray * dataArr;
@end

@implementation YJProfileViewController

static NSString * identifier = @"profileCell";
static CGFloat margin = 10.f;


-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        CGFloat itemWidth = (self.view.frame.size.width - 4 * margin) / 3;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, YJNavBarHeight + 200, self.view.frame.size.width, self.view.frame.size.height - 64 -200 - YJTabBarHeight) collectionViewLayout:flowLayout];
        _collectionView.contentInset = UIEdgeInsetsMake(margin, margin, margin, margin);
        [_collectionView registerNib:[UINib nibWithNibName:@"YJProfileCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
        _collectionView.dataSource = self;
    }
    return _collectionView;;
}

- (NSArray *)dataArr{
    if (!_dataArr) {
        
        _dataArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"YJProfileCollectionViewList" ofType:@".plist"]];
    }
    return _dataArr;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgationItems];
    
    YJUserMessageView *userMsg = [YJUserMessageView userMessageView];
    userMsg.frame = CGRectMake(0, YJNavBarHeight, self.view.frame.size.width, 200);
    [self.view addSubview:userMsg];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - 导航条透明
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
//}

#pragma mark - 配置导航条
-(void)setNavgationItems
{
    UIBarButtonItem *noticeItem = [UIBarButtonItem btnWithImageName:@"notice" target:self action:@selector(noticeBtnDidClicked)];
    
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:NULL action:NULL];
    spaceItem.width = 15;
    
    UIBarButtonItem *settingItem = [UIBarButtonItem btnWithImageName:@"setting" target:self action:@selector(settingBtnDidClicked)];
    
    
    self.navigationItem.rightBarButtonItems = @[spaceItem, settingItem, spaceItem, noticeItem];
}

-(void)noticeBtnDidClicked
{
    NSLog(@"%s",__func__);
}
-(void)settingBtnDidClicked
{
    [self.navigationController pushViewController:[[YJSettingTableViewController alloc] init] animated:YES];
    
}

#pragma mark - UICollectionViewDataSource
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    YJProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section { 
    return self.dataArr.count;
}

@end
