//
//  YJPreNextView.m
//  Reader
//
//  Created by Yang on 2020/6/25.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJPreNextView.h"
#import "Masonry.h"

@interface YJPreNextView ()
@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)UIImageView *middleView;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, assign) BOOL isNight;;
@end

@implementation YJPreNextView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTopView];
        [self setMiddleView];
        [self setBottomView];
        _isNight = NO;
    }
    return self;
}


-(void)setBtn:(UIButton *)btn withtitle:(NSString *)title{
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:title forState:UIControlStateNormal];
}

-(void)setTopView{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YJScreenWidth, 40)];
    [self addSubview:_topView];

    UIButton *preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setBtn:preBtn withtitle:@"上一章"];
    [preBtn addTarget:self action:@selector(preBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:preBtn];
    [preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left);
        make.top.equalTo(_topView.mas_top);
        make.bottom.equalTo(_topView.mas_bottom);
        make.width.equalTo(_topView.mas_width).with.multipliedBy(0.2);
    }];
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setBtn:nextBtn withtitle:@"下一章"];
    [nextBtn addTarget:self action:@selector(nextBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_topView.mas_right);
        make.top.equalTo(_topView.mas_top);
        make.bottom.equalTo(_topView.mas_bottom);
        make.width.equalTo(_topView.mas_width).with.multipliedBy(0.2);
    }];
    
    
    
    UISlider *slider = [[UISlider alloc] init];
    [_topView addSubview:slider];
    self.slider = slider;
    slider.value = 0.0;
    slider.enabled = NO;
    slider.minimumTrackTintColor = [UIColor redColor];
    [slider setThumbImage:[UIImage imageNamed:@"progressSlider2"] forState:UIControlStateNormal];

    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(preBtn.mas_right);
        make.right.equalTo(nextBtn.mas_left);
        make.top.equalTo(_topView.mas_top);
        make.bottom.equalTo(_topView.mas_bottom);
    }];
}

-(void)setMiddleView{
    _middleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), YJScreenWidth, 2)];
    _middleView.image = [UIImage imageNamed:@"fenge"];
    [self addSubview:_middleView];
}

-(void)setBottomView{
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_middleView.frame), YJScreenWidth, 60)];
    [self addSubview:_bottomView];

    UIButton *muluBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:muluBtn];
    [muluBtn setImage:[UIImage imageNamed:@"目录"] forState:UIControlStateNormal];
    [muluBtn addTarget:self action:@selector(muluBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [muluBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView.mas_left);
        make.top.equalTo(_middleView.mas_bottom);
        make.bottom.equalTo(_bottomView.mas_bottom);
        make.width.equalTo(_bottomView.mas_width).with.multipliedBy(0.15);
    }];

    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:moreBtn];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    [moreBtn setTintColor:[UIColor whiteColor]];
    [moreBtn setTitle:@"Aa" forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(_bottomView.mas_right);
       make.top.equalTo(_bottomView.mas_top);
       make.bottom.equalTo(_bottomView.mas_bottom);
       make.width.equalTo(_bottomView.mas_width).with.multipliedBy(0.15);
    }];
    
    UIButton *nigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:nigthBtn];
    [nigthBtn setImage:[UIImage imageNamed:@"night"] forState:UIControlStateNormal];
    [nigthBtn addTarget:self action:@selector(btnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [nigthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottomView.mas_centerX);
        make.centerY.equalTo(moreBtn.mas_centerY);
        make.width.equalTo(moreBtn.mas_width);
        make.height.equalTo(moreBtn.mas_height);
    }];
}


-(void)btnDidClicked:(UIButton *)btn{
    _isNight = !_isNight;
    CGFloat brightness =  _isNight ? 0.5 : 0.2;
    [[UIScreen mainScreen] setBrightness:brightness];
}

-(void)preBtnDidClicked:(UIButton *)btn{
    if (_slider.value != 0.0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_preChapter object:_slider];
        
    }
}
-(void)nextBtnDidClicked:(UIButton *)btn{
    if (_slider.value != 1.0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_NextChapter object:_slider];
    }
}
-(void)muluBtnDidClicked:(UIButton *)btn{
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_showLeftVc object:nil];
}

-(void)moreBtnDidClicked:(UIButton *)btn{
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_moreBtnClick object:nil];
}

@end
