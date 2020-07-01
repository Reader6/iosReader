//
//  YJLeftTopScrollView.m
//  Reader
//
//  Created by Yang on 2020/6/26.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJLeftTopView.h"

@interface YJLeftTopView ()
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSMutableArray * btnArr;
@property (nonatomic, strong) UIView * sliderView;
@end

@implementation YJLeftTopView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    self.btnArr = [NSMutableArray array];
    float width = self.frame.size.width / _titles.count;
    
    for (int i = 0; i < _titles.count; i++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(width * i, YJStatusBarHeight, width, self.frame.size.height - YJStatusBarHeight - 4)];
        btn.tag = YJTagIndex + i;
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArr addObject:btn];
        [self addSubview:btn];
    }
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 4, 30, 2)];
    CGPoint center = CGPointMake(width / 2, self.sliderView.center.y);
    _sliderView.center = center;
    _sliderView.backgroundColor = [UIColor redColor];
    [self addSubview:_sliderView];
    
    
    
    UIView *fengeView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 2, self.frame.size.width, 1)];
    fengeView.backgroundColor = [UIColor grayColor];
    [self addSubview:fengeView];
}

-(void)btnDidClicked:(UIButton *)btn{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint center = CGPointMake(btn.center.x, weakSelf.sliderView.center.y);
        weakSelf.sliderView.center = center;
    }];
    if ([self.delegate respondsToSelector:@selector(hasBtnDidClick:)]) {
        [self.delegate hasBtnDidClick:(btn.tag - YJTagIndex)];
    }
}

@end
