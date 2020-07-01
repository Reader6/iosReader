//
//  YJMoreView.m
//  Reader
//
//  Created by Yang on 2020/6/25.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJMoreView.h"
#import "YJFirstView.h"
#import "YJSecondView.h"

@interface YJMoreView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIPageControl * pageControl;

@end


CGFloat moreViewHeight = 0;

@implementation YJMoreView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        moreViewHeight = YJIsIphoneX ? self.frame.size.height - YJBottomSafeHeight : self.frame.size.height;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, YJScreenWidth, moreViewHeight - 30)];
        [self addSubview:_scrollView];
        _scrollView.contentSize = CGSizeMake(YJScreenWidth * 2, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;

        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame), YJScreenWidth, 30)];
        [self addSubview:_pageControl];
        _pageControl.numberOfPages = 2;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        
        [self setUpScrollView];
    }
    return self;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentIndex = scrollView.contentOffset.x/YJScreenWidth;
    _pageControl.currentPage = currentIndex;
}

-(void)setUpScrollView{
    
    YJFirstView *firstView = [[YJFirstView alloc] initWithFrame:CGRectMake(0, 0, YJScreenWidth, _scrollView.frame.size.height)];
    [_scrollView addSubview:firstView];
    
    YJSecondView *recondView = [[YJSecondView alloc] initWithFrame:CGRectMake(YJScreenWidth, 0, YJScreenWidth, _scrollView.frame.size.height)];
    [_scrollView addSubview:recondView];
}



@end
