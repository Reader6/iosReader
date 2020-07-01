//
//  YJFirstView.m
//  Reader
//
//  Created by Yang on 2020/6/25.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJFirstView.h"
#import "Masonry.h"
#import "UIImage+YJImage.h"
#import "YJReadConfig.h"


@interface ThemeButton : UIButton
@property (nonatomic, strong) UIColor * theme;
@end

@implementation ThemeButton

@end

@interface YJFirstView ()
@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UIView * middleView;
@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UIButton * preBtn;
@property (nonatomic, strong) UIButton * preInterval;
@property (nonatomic, strong) UILabel *fontLabel;
@property (nonatomic, strong) UISlider * slider;
@end

static CGFloat firstViewIndex = 150;

@implementation YJFirstView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setScrollViewTopView];
        [self setScrollViewMiddleView];
        [self setColocView];
        [self setIntervalView];
    }
    return self;
}

-(void)setScrollViewTopView{
    _topView = [[UIView alloc] init];
    [self addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height).with.dividedBy(4);
    }];
    
    UIImageView *lowLight = [[UIImageView alloc] init];
    [_topView addSubview:lowLight];
    lowLight.image = [UIImage imageNamed:@"brightnessLow"];
    lowLight.contentMode = UIViewContentModeCenter;
    [lowLight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left);
        make.top.equalTo(_topView.mas_top);
        make.bottom.equalTo(_topView.mas_bottom);
        make.width.equalTo(_topView.mas_width).with.multipliedBy(0.15);
    }];
    
    
    UIImageView *higtLight = [[UIImageView alloc] init];
    [_topView addSubview:higtLight];
    higtLight.image = [UIImage imageNamed:@"brightnessUp"];
    higtLight.contentMode = UIViewContentModeCenter;
    [higtLight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_topView.mas_right);
        make.top.equalTo(_topView.mas_top);
        make.bottom.equalTo(_topView.mas_bottom);
        make.width.equalTo(_topView.mas_width).with.multipliedBy(0.15);
    }];
    
    
    UISlider *slider = [[UISlider alloc] init];
    [_topView addSubview:slider];
    self.slider = slider;
    slider.value = 0.5;
    slider.minimumTrackTintColor = [UIColor redColor];
    [slider setThumbImage:[UIImage imageNamed:@"progressSlider2"] forState:UIControlStateNormal];
    [slider addTarget:self action:@selector(justBrightness) forControlEvents:UIControlEventValueChanged];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lowLight.mas_right);
        make.right.equalTo(higtLight.mas_left);
        make.top.equalTo(_topView.mas_top);
        make.bottom.equalTo(_topView.mas_bottom);
    }];
}

-(void)justBrightness{
    [[UIScreen mainScreen] setBrightness:_slider.value];
}

-(void)setScrollViewMiddleView{
    _middleView = [[UIView alloc] init];
    [self addSubview:_middleView];
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(_topView.mas_bottom);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height).with.dividedBy(4);
    }];
    
    UIButton *lowFont = [[UIButton alloc] init];
    [_middleView addSubview:lowFont];
    lowFont.tag = firstViewIndex + YJTagIndex + 0;
    [lowFont addTarget:self action:@selector(fontBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [lowFont setImage:[UIImage imageNamed:@"fontsizeDecrease"] forState:UIControlStateNormal];
    lowFont.layer.borderWidth = 1;
    lowFont.layer.borderColor = [UIColor grayColor].CGColor;
    lowFont.layer.cornerRadius = 5;
    [lowFont mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_middleView.mas_left).offset(20);
        make.top.equalTo(_middleView.mas_top).offset(20);
        make.bottom.equalTo(_middleView.mas_bottom).offset(-20);
        make.width.mas_equalTo(80);
    }];
    
    
    
    UILabel *fontLabel = [[UILabel alloc] init];
    [_middleView addSubview:fontLabel];
    self.fontLabel = fontLabel;
    fontLabel.text = @"14";
    fontLabel.textAlignment = NSTextAlignmentCenter;
    fontLabel.tintColor = [UIColor whiteColor];
    [fontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lowFont.mas_centerY);
        make.left.equalTo(lowFont.mas_right);
        make.width.equalTo(lowFont.mas_width);
        make.height.equalTo(lowFont.mas_height);
    }];
    
    
    UIButton *highFont = [[UIButton alloc] init];
    [_middleView addSubview:highFont];
    highFont.tag = firstViewIndex + YJTagIndex + 1;
    [highFont addTarget:self action:@selector(fontBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [highFont setImage:[UIImage imageNamed:@"fontsizeIncrease"] forState:UIControlStateNormal];
    highFont.layer.borderWidth = 1;
    highFont.layer.borderColor = [UIColor grayColor].CGColor;
    highFont.layer.cornerRadius = 5;
    [highFont mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fontLabel.mas_right);
        make.top.equalTo(lowFont.mas_top);
        make.bottom.equalTo(lowFont.mas_bottom);
        make.width.equalTo(lowFont.mas_width);
    }];
    
    UIImageView *fontimageView = [[UIImageView alloc] init];
    [_middleView addSubview:fontimageView];
    fontimageView.image = [UIImage imageNamed:@"font"];
    fontimageView.contentMode = UIViewContentModeCenter;
    
    [fontimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_middleView.mas_right).offset(-20);
        make.top.equalTo(highFont.mas_top);
        make.bottom.equalTo(highFont.mas_bottom);
        make.width.equalTo(highFont.mas_width);
    }];
}

-(void)fontBtnClick:(UIButton *)btn{
    int index =  [_fontLabel.text intValue];
    if (btn.tag == firstViewIndex + YJTagIndex + 0) {
        if (index == 10) return;
        [YJReadConfig shareInstance].fontSize = --index;
    }else{
        if (index == 18) return;
        [YJReadConfig shareInstance].fontSize = ++index;
    }
    _fontLabel.text = [NSString stringWithFormat:@"%d", index];
}

-(void)setColocView{
    _colorView = [[UIView alloc] init];
    [self addSubview:_colorView];

    [_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(_middleView.mas_bottom);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height).with.dividedBy(4);
    }];
    
    ThemeButton *btn1 = [[ThemeButton alloc] init];
    [_colorView addSubview:btn1];
    ThemeButton *btn2 = [[ThemeButton alloc] init];
    [_colorView addSubview:btn2];
    ThemeButton *btn3 = [[ThemeButton alloc] init];
    [_colorView addSubview:btn3];
    ThemeButton *btn4 = [[ThemeButton alloc] init];
    [_colorView addSubview:btn4];
    ThemeButton *btn5 = [[ThemeButton alloc] init];
    [_colorView addSubview:btn5];
    ThemeButton *btn6 = [[ThemeButton alloc] init];
    [_colorView addSubview:btn6];
    
    
    [self setimageView:_colorView withBtn:btn1 color:UIColorFromHex(0xe8e8e8)];
    [self setimageView:btn1 withBtn:btn2 color:UIColorFromHex(0xe1d6c4)];
    [self setimageView:btn2 withBtn:btn3 color:UIColorFromHex(0xd5bc84)];
    [self setimageView:btn3 withBtn:btn4 color:UIColorFromHex(0x9acea0)];
    [self setimageView:btn4 withBtn:btn5 color:UIColorFromHex(0x30445c)];
    [self setimageView:btn5 withBtn:btn6 color:UIColorFromHex(0x605048)];
    
}

-(void)imageViewDidClick:(ThemeButton *)btn{
    _preBtn.layer.borderWidth = 0;
    btn.layer.borderWidth = 1;
    _preBtn = btn;
    
    [YJReadConfig shareInstance].theme = btn.theme;
}

-(void)setimageView:(UIView *)preView withBtn:(ThemeButton *)btn color:(UIColor *)color{
    
    if (preView == _colorView) {
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(preView.mas_left).offset(20);
            make.top.equalTo(preView.mas_top).offset(15);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(30);
        }];
        btn.layer.borderWidth = 1;
        _preBtn = btn;
    }else{
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(preView.mas_right).offset(30);
            make.top.equalTo(preView.mas_top);
            make.width.height.equalTo(preView);
        }];
    }
    btn.theme = color;
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(imageViewDidClick:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)setIntervalView{
    UIView *interValView = [[UIView alloc] init];
    [self addSubview:interValView];
    [interValView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(_colorView.mas_bottom);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height).with.dividedBy(4);
    }];
    
    UIButton *sanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sanBtn.tag = 14.f;
    [interValView addSubview:sanBtn];
    UIButton *siBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    siBtn.tag = 12.f;
    [interValView addSubview:siBtn];
    UIButton *wuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wuBtn.tag = 10.f;
    [interValView addSubview:wuBtn];
    
    [siBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(interValView.mas_centerX);
        make.centerY.equalTo(interValView.mas_centerY);
        make.width.equalTo(interValView.mas_width).with.dividedBy(3).offset(-30);
        make.bottom.equalTo(interValView.mas_bottom).offset(-10);
        make.top.equalTo(interValView.mas_top).offset(10);
    }];
    [siBtn setImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
    [siBtn setImage:[UIImage imageNamed:@"4_highseleted"] forState:UIControlStateSelected];
    siBtn.layer.borderColor = [UIColor redColor].CGColor;
    [siBtn addTarget:self action:@selector(intervalbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [sanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(siBtn.mas_left).offset(-20);
        make.top.equalTo(siBtn.mas_top);
        make.width.equalTo(siBtn.mas_width);
        make.bottom.equalTo(siBtn.mas_bottom);
    }];
    [sanBtn setImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
    [sanBtn setImage:[UIImage imageNamed:@"3_highseleted"] forState:UIControlStateSelected];
    sanBtn.layer.borderWidth = 1;
    sanBtn.layer.borderColor = [UIColor redColor].CGColor;
    _preInterval = sanBtn;
    sanBtn.selected = YES;
    [sanBtn addTarget:self action:@selector(intervalbtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [wuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(siBtn.mas_right).offset(20);
        make.top.equalTo(siBtn.mas_top);
        make.width.equalTo(siBtn.mas_width);
        make.bottom.equalTo(siBtn.mas_bottom);
    }];
    [wuBtn setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
    [wuBtn setImage:[UIImage imageNamed:@"5_highseleted"] forState:UIControlStateSelected];
    wuBtn.layer.borderColor = [UIColor redColor].CGColor;
    [wuBtn addTarget:self action:@selector(intervalbtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)intervalbtnClick:(UIButton *)btn{
    _preInterval.layer.borderWidth = 0;
    _preInterval.selected = NO;
    btn.layer.borderWidth = 1;
    btn.selected = YES;
    _preInterval = btn;
    
    [YJReadConfig shareInstance].lineSpace = btn.tag;
}
@end



