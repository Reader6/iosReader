//
//  YJLeftContentScrollView.m
//  Reader
//
//  Created by Yang on 2020/6/26.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJLeftContentScrollView.h"
#import "YJListTableView.h"
#import "YJChapterItem.h"

@interface YJLeftContentScrollView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray<YJChapterItem *> * chapters;
@property (nonatomic, strong) NSMutableArray * tableViews;
@end

@implementation YJLeftContentScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableViews = [NSMutableArray array];
        self.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.scrollEnabled = NO;
        self.bounces = NO;
        [self addTableViews];
         
    }
    return self;
}

-(void)addTableViews{
    for (int i = 0; i < 3; i++) {
        YJListTableView *tableView = [[YJListTableView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = [[UIView alloc] init];
        [self addSubview:tableView];
        [_tableViews addObject:tableView];
    }
   
}

-(void)updateAllTableView:(NSArray *)chapters{
    _chapters = chapters;
    for (UITableView *tableViwe  in _tableViews) {
        [tableViwe reloadData];
    }
}
-(void)updateChapterTableView:(NSArray *)chapters{
    _chapters = chapters;
    [_tableViews[0] reloadData];
}


- (void)hasBtnDidClick:(NSInteger)index {
    [self setContentOffset:CGPointMake(self.frame.size.width * index, 0) animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"shapterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    YJChapterItem *item = _chapters[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s", __func__);
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_hiddenLeftVc object:@(indexPath.row)];
}

@end
