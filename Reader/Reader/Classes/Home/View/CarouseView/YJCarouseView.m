//
//  YJCarouseView.m
//  Reader
//
//  Created by Yang on 2020/6/13.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJCarouseView.h"

@interface YJCarouseView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIPageControl * pageControl;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) NSArray * imageArr;
@property (nonatomic, assign) NSInteger prePageIndex;
@end

static const double YJTimerInterval = 2.0;

@implementation YJCarouseView
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, YJScreenWidth, self.frame.size.height)];
        _scrollView.contentSize = CGSizeMake(YJScreenWidth * _imageArr.count, self.frame.size.height);
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(YJScreenWidth, 0);
    }
    return _scrollView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 30, YJScreenWidth, 30)];
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
        _pageControl.enabled = NO;
    }
    return _pageControl;
}

- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray<UIImage *> *)imageArr{
    if (imageArr.count == 0) return nil;
    self = [super initWithFrame:frame];
    self.imageArr = (NSMutableArray *)imageArr;
    if (_imageArr.count == 1) {
        [self signleImage];
    }else{
        [self moreThanDoubleImages];
    }
    [self addSubview:self.pageControl];
    return self;
}


- (UIImageView *)creatImageView{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidLClicked)];
    [imageView addGestureRecognizer:tap];
    return imageView;
}

-(void)imageViewDidLClicked{
    NSLog(@"%s", __func__);
}

#pragma mark - imageArr只有一张图
-(void)signleImage{
    self.pageControl.numberOfPages = 1;
    UIImageView *imageView = [self creatImageView];
    imageView.frame = CGRectMake(0, 0, YJScreenWidth, self.frame.size.height);
    imageView.image = [UIImage imageNamed:_imageArr[0]];
    [self addSubview:imageView];
  
}

-(void)moreThanDoubleImages{
    self.pageControl.numberOfPages = _imageArr.count;
    //处理图片
    NSMutableArray *temp = [NSMutableArray arrayWithArray:_imageArr];
    NSString *firstImageName = self.imageArr.firstObject;
    NSString *lastImageName = self.imageArr.lastObject;
    [temp insertObject:lastImageName atIndex:0];
    [temp addObject:firstImageName];
    self.imageArr = temp;
    
    
    [self addSubview:self.scrollView];
    
    for (int i = 0; i < _imageArr.count; i++) {
        UIImageView *imageView = [self creatImageView];
        imageView.frame = CGRectMake(YJScreenWidth * i, 0, YJScreenWidth, self.frame.size.height);
        imageView.image = [UIImage imageNamed:_imageArr[i]];
        [_scrollView addSubview:imageView];
    }
    [self startTimer];
}

-(void)startTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:YJTimerInterval target:self selector:@selector(scrollViewTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)stopTimer{
    [_timer invalidate];
    _timer = nil;
}

-(void)scrollViewTimer
{
    float offset_X = _scrollView.contentOffset.x;
    offset_X += YJScreenWidth;
    
    if (offset_X == YJScreenWidth * (_imageArr.count - 1)) {
        _pageControl.currentPage = 0;
    }else if(offset_X == 0){
        _pageControl.currentPage = _imageArr.count - 3;
    }else{
        _pageControl.currentPage = offset_X/YJScreenWidth - 1;
    }
    
    CGPoint resultPoint = CGPointMake(offset_X, 0);
    
    if (offset_X > YJScreenWidth * (_imageArr.count - 1)){
        _pageControl.currentPage = 1;
        _scrollView.contentOffset = CGPointMake(YJScreenWidth, 0);
        _scrollView.contentOffset = CGPointMake(YJScreenWidth * 2, 0);
    }else{
        [_scrollView setContentOffset:resultPoint animated:YES];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int pageImageView = scrollView.contentOffset.x/YJScreenWidth;
    if (pageImageView == self.imageArr.count - 1) {
        pageImageView = 0;
        CGPoint resultPoint = CGPointMake(YJScreenWidth, 0);
        
        [_scrollView setContentOffset:resultPoint animated:NO];
        _pageControl.currentPage = pageImageView;
    }else if(pageImageView == 0){
        pageImageView = (int)(_imageArr.count - 2);
        CGPoint resultPoint = CGPointMake(YJScreenWidth * pageImageView, 0);
        [_scrollView setContentOffset:resultPoint animated:NO];
        _pageControl.currentPage = pageImageView - 1;
    }else{
        _pageControl.currentPage = pageImageView - 1;
    }
    [self startTimer];
}



@end
