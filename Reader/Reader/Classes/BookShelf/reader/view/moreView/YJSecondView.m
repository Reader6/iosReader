//
//  YJSecondView.m
//  Reader
//
//  Created by Yang on 2020/6/25.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJSecondView.h"
#import "Masonry.h"
#import "YJMoreButton.h"
#import "UIImage+YJImage.h"

@interface YJSecondView ()
@property (nonatomic, strong) UIView *methodView;
@property (nonatomic, strong) UIButton * prebtn;
@end

@implementation YJSecondView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn setTitleColor:UIColorFromHex(0x6d6d6d) forState:UIControlStateNormal];
        [btn setTitle:@"更多设置 >>" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(30);
        }];
        
        
        [self setFanyeMethod];
        [self setOtherSetting];
    }
    return self;
}


-(void)moreBtnClick{
    NSLog(@"%s", __func__);
}

-(void)setFanyeMethod{
    UIView *methodView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YJScreenWidth, 60)];
    [self addSubview:methodView];
    _methodView = methodView;

    UIButton *fangzhenBtn = [self createBtnWithTitle:@"仿真"];
    [_methodView addSubview:fangzhenBtn];
    _prebtn = fangzhenBtn;
    fangzhenBtn.layer.borderColor = [UIColorFromHex(0xbe574e) CGColor];
    [fangzhenBtn setTitleColor:UIColorFromHex(0xbe574e) forState:UIControlStateNormal];
    
    [fangzhenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(methodView.mas_left).offset(20);
        make.top.equalTo(methodView.mas_top).offset(20);
        make.width.equalTo(methodView.mas_width).with.dividedBy(4).offset(-25);
        make.height.mas_equalTo(40);
    }];
    
    
    
    UIButton *fugaiBtn = [self createBtnWithTitle:@"覆盖"];
    [_methodView addSubview:fugaiBtn];
    [fugaiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fangzhenBtn.mas_right).offset(20);
        make.top.equalTo(fangzhenBtn.mas_top);
        make.width.equalTo(fangzhenBtn.mas_width);
        make.height.equalTo(fangzhenBtn.mas_height);
    }];
    
    
    UIButton *huadongBtn = [self createBtnWithTitle:@"滑动"];
    [_methodView addSubview:huadongBtn];
    [huadongBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fugaiBtn.mas_right).offset(20);
        make.top.equalTo(fugaiBtn.mas_top);
        make.width.equalTo(fangzhenBtn.mas_width);
        make.height.equalTo(fangzhenBtn.mas_height);
    }];

    UIButton *noneBtn = [self createBtnWithTitle:@"无"];
    [_methodView addSubview:noneBtn];
    [noneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(huadongBtn.mas_right).offset(20);
        make.top.equalTo(huadongBtn.mas_top);
        make.width.equalTo(fangzhenBtn.mas_width);
        make.height.equalTo(fangzhenBtn.mas_height);
    }];
    
    
}


-(UIButton *)createBtnWithTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(fanyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor = [UIColorFromHex(0x474747) CGColor];
    return btn;
}

-(void)fanyeBtnClick:(UIButton *)btn{
    _prebtn.layer.borderColor = [UIColorFromHex(0x474747) CGColor];
    [_prebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.borderColor = [UIColorFromHex(0xbe574e) CGColor];
    [btn setTitleColor:UIColorFromHex(0xbe574e) forState:UIControlStateNormal];
    _prebtn = btn;
}

-(void)setOtherSetting{
    
    CGFloat margin = YJIsIphoneX ? 40 : 0;
    
    UIView *otherView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_methodView.frame) + margin, YJScreenWidth, 150)];
    [self addSubview:otherView];
    
    YJMoreButton *huyanBtn = [YJMoreButton createMoreButton];
    [otherView addSubview:huyanBtn];
    
    YJMoreButton *quanpingBtn = [YJMoreButton createMoreButton];
    [otherView addSubview:quanpingBtn];

    YJMoreButton *yemaBtn = [YJMoreButton createMoreButton];
    [otherView addSubview:yemaBtn];

    YJMoreButton *autoBtn = [YJMoreButton createMoreButton];
    [otherView addSubview:autoBtn];
    
    [huyanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(otherView.mas_left).offset(20);
        make.top.equalTo(otherView.mas_top);
        make.width.equalTo(otherView.mas_width).with.dividedBy(4).offset(-25);
        make.height.mas_equalTo(100);
    }];
    [huyanBtn.btn setImage:[UIImage originImageWithName:@"protectEyeNormal"] forState:UIControlStateNormal];
    [huyanBtn.btn setImage:[UIImage originImageWithName:@"protectEyeSelect"] forState:UIControlStateSelected];
    huyanBtn.label.text = @"护眼模式";
    [huyanBtn.btn addTarget:self action:@selector(otherBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [quanpingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(huyanBtn.mas_right).offset(20);
        make.top.equalTo(huyanBtn.mas_top);
        make.width.equalTo(huyanBtn.mas_width);
        make.height.equalTo(huyanBtn.mas_height);
    }];
    [quanpingBtn.btn setImage:[UIImage originImageWithName:@"pageturnunseleced"] forState:UIControlStateNormal];
    [quanpingBtn.btn setImage:[UIImage originImageWithName:@"pageturnseleced"] forState:UIControlStateSelected];
    quanpingBtn.label.text = @"全屏翻页";
    [quanpingBtn.btn addTarget:self action:@selector(otherBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [yemaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(quanpingBtn.mas_right).offset(20);
        make.top.equalTo(quanpingBtn.mas_top);
        make.width.equalTo(quanpingBtn.mas_width);
        make.height.equalTo(quanpingBtn.mas_height);
    }];
    
    [yemaBtn.btn setImage:[UIImage originImageWithName:@"pagenumberunseleced"] forState:UIControlStateNormal];
    [yemaBtn.btn setImage:[UIImage originImageWithName:@"pagenumberseleced"] forState:UIControlStateSelected];
    yemaBtn.btn.selected = YES;
    yemaBtn.label.text = @"页码进度";
    [yemaBtn.btn addTarget:self action:@selector(otherBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [autoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(yemaBtn.mas_right).offset(20);
           make.top.equalTo(yemaBtn.mas_top);
           make.width.equalTo(yemaBtn.mas_width);
           make.height.equalTo(yemaBtn.mas_height);
    }];
    [autoBtn.btn setImage:[UIImage originImageWithName:@"autoread"] forState:UIControlStateNormal];
    autoBtn.label.text = @"自动阅读";
}


-(void)otherBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
}
@end
