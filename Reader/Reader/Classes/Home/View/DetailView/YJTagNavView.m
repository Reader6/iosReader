//
//  YJTagNavView.m
//  Reader
//
//  Created by Yang on 2020/6/17.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJTagNavView.h"

@interface YJTagNavView ()
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSMutableArray * btnArr;
@property (nonatomic, strong) UIView * sliderView;
@end

@implementation YJTagNavView

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
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(width * i, 0, width, self.frame.size.height)];
        btn.tag = YJTagIndex + i;
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [self btnSelected:btn];
        }
        [self.btnArr addObject:btn];
        [self addSubview:btn];
    }
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, 30, 1)];
    CGPoint center = CGPointMake(width / 2, self.sliderView.center.y);
    _sliderView.center = center;
    _sliderView.backgroundColor = [UIColor redColor];
    [self addSubview:_sliderView];
}

-(void)btnDidClicked:(UIButton *)btn{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint center = CGPointMake(btn.center.x, weakSelf.sliderView.center.y);
        weakSelf.sliderView.center = center;
    }];
    for (UIButton *subBtn in _btnArr) {
        subBtn == btn ? [self btnSelected:subBtn] : [self normalBtn:subBtn];
    }
    if ([self.delegate respondsToSelector:@selector(hasBtnDidClick:)]) {
        [self.delegate hasBtnDidClick:(btn.tag - YJTagIndex)];
    }
}

-(void)btnSelected:(UIButton *)btn{
    btn.selected = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
}
-(void)normalBtn:(UIButton *)btn{
    btn.selected = NO;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
}

-(void)selectBtnWithTag:(NSInteger)tag{
    NSInteger index = tag + YJTagIndex;
    
    for (UIButton *btn in _btnArr) {
        if (btn.tag == index) {
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:0.2 animations:^{
                CGPoint center = CGPointMake(btn.center.x, weakSelf.sliderView.center.y);
                weakSelf.sliderView.center = center;
            } completion:^(BOOL finished) {
                [self btnSelected:btn];
            }];
        }else{
            [self normalBtn:btn];
        }
    }
}

@end
