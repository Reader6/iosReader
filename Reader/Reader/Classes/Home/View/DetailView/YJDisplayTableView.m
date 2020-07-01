//
//  YJDisplayTableView.m
//  Reader
//
//  Created by Yang on 2020/6/17.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJDisplayTableView.h"


@interface YJDisplayTableView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray * dataArr;
@end

static NSString * displayTableViewCell = @"displayTableViewCell";
@implementation YJDisplayTableView
-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"displayTableViewList" ofType:@".plist"]];
    }
    return _dataArr;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [[UIView alloc] init];
    }
    return self;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:displayTableViewCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:displayTableViewCell];
    }
    NSDictionary *dict = _dataArr[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.imageView.image = [UIImage imageNamed:dict[@"imageName"]];
    cell.detailTextLabel.text = dict[@"introduce"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}




@end
