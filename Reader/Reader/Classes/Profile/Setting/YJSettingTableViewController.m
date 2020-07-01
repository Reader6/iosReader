//
//  YJSettingTableViewController.m
//  Reader
//
//  Created by Yang on 2020/6/11.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJSettingTableViewController.h"
#import "UIBarButtonItem+YJBarButtonItem.h"

@interface YJSettingTableViewController () <UIGestureRecognizerDelegate>
{
    id<UIGestureRecognizerDelegate> _delegate;
}
@property (nonatomic, copy) NSArray * dataArr;
@end

@implementation YJSettingTableViewController

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"settingList" ofType:@".plist"]];
    }
    return _dataArr;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem btnWithImageName:@"goBack" target:self action:@selector(back:)];
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

- (void)back:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
        return self.navigationController.childViewControllers.count > 1;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}
     

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

static NSString* identifier = @"settingCell";
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
