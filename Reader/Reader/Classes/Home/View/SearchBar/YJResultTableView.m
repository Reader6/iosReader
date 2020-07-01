//
//  YJResultTableView.m
//  Reader
//
//  Created by Yang on 2020/6/16.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJResultTableView.h"
#import "YJSearchController.h"

@interface YJResultTableView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) NSMutableArray *results;
@end

@implementation YJResultTableView
- (NSArray *)datas {
    if (_datas == nil) {
        _datas = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"resultlist" ofType:@".plist"]];
    }
    return _datas;
}

- (NSMutableArray *)results {
    if (_results == nil) {
        _results = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _results;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor systemGrayColor];
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [[UIView alloc] init];
    }
    return self;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = [self.results objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.results.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择了搜索结果中的%@", [self.results objectAtIndex:indexPath.row]);
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *inputStr = searchController.searchBar.text;
    if (self.results.count > 0) {
        [self.results removeAllObjects];
    }
    for (NSString *str in self.datas) {
        
        if ([str.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
            
            [self.results addObject:str];
        }
        
    }
    if (self.results.count == 0 && searchController.searchBar.text.length != 0) {
        [self.results addObject:@"没有该书"];
    }
    [self reloadData];
}
@end
