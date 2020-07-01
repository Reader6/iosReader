//
//  YJDetailScrollView.m
//  Reader
//
//  Created by Yang on 2020/6/17.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJDetailScrollView.h"
#import "YJDisplayTableView.h"

@interface YJDetailScrollView ()<UIScrollViewDelegate>

@end

@implementation YJDetailScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(YJScreenWidth * 4, self.frame.size.height);
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.bounces = NO;
        [self addTableViews];
    }
    return self;
}

-(void)addTableViews{
    for (int i = 0; i < 4; i++) {
        YJDisplayTableView *tableView = [[YJDisplayTableView alloc] initWithFrame:CGRectMake(YJScreenWidth * i, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        [self addSubview:tableView];
    }
}

- (void)hasBtnDidClick:(NSInteger)index {
    [self setContentOffset:CGPointMake(YJScreenWidth * index, 0) animated:NO];
}


#pragma mark - YJDetailScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger selectedIndex = scrollView.contentOffset.x/YJScreenWidth;
    [_tagView selectBtnWithTag:selectedIndex];
}

@end
