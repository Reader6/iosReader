//
//  YJReaderPopView.m
//  Reader
//
//  Created by Yang on 2020/6/25.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJReaderEasyPopView.h"
#import "YJPreNextView.h"
#import "YJReaderMorePopView.h"


@implementation YJReaderEasyPopView

UIView *bgEasyView;
YJReaderEasyPopView *easyPopView;
CGFloat easyPopViewHeight = 102;

+(void)readerEasyPopView{
    
    UIWindow *win = [[[UIApplication sharedApplication] windows] firstObject];
    if (!bgEasyView) {
         bgEasyView = [[UIView alloc] initWithFrame:CGRectMake(0, YJNavBarHeight, YJScreenWidth, YJScreenHeight - YJNavBarHeight)];
        if (easyPopView) {
            [win insertSubview:bgEasyView belowSubview:easyPopView];
        }else{
            [win addSubview:bgEasyView];
        }
           UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundClick)];
           [bgEasyView addGestureRecognizer:tap];
    }
    if (!easyPopView) {
        easyPopViewHeight = YJIsIphoneX ? (easyPopViewHeight + YJBottomSafeHeight) : easyPopViewHeight;
        easyPopView = [[YJReaderEasyPopView alloc] initWithFrame:CGRectMake(0, YJScreenHeight, YJScreenWidth, easyPopViewHeight)];
        [win addSubview:easyPopView];
        easyPopView.backgroundColor = UIColorFromHex(0x595959);
    }
    [self show];
}

+(void)show{
    [UIView animateWithDuration:0.3 animations:^{
        easyPopView.frame = CGRectMake(0, YJScreenHeight - easyPopViewHeight, YJScreenWidth, easyPopViewHeight);
    }];
    
}

+(void)removeEasyPopViewWithAnimation:(BOOL)isAnimation{
    if (easyPopView != nil) {
        
        if (isAnimation) {
            [UIView animateWithDuration:0.3 animations:^{
                easyPopView.frame = CGRectMake(0, YJScreenHeight, YJScreenWidth, easyPopViewHeight);
            } completion:^(BOOL finished) {
                [bgEasyView removeFromSuperview];
                bgEasyView = nil;
                easyPopViewHeight = 102;
            }];
           
        }else{
            easyPopView.frame = CGRectMake(0, YJScreenHeight, YJScreenWidth, easyPopViewHeight);
            [bgEasyView removeFromSuperview];
            bgEasyView = nil;
            easyPopViewHeight = 102;
        }
        
         [[NSNotificationCenter defaultCenter] postNotificationName:Notification_removePopView object:nil];
    }
}


+(void)tapBackgroundClick{
    [self removeEasyPopViewWithAnimation:YES];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        YJPreNextView * preNextView = [[YJPreNextView alloc] initWithFrame:CGRectMake(0, 0, YJScreenWidth, easyPopViewHeight)];
        [self addSubview:preNextView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moreBtnDidClick) name:Notification_moreBtnClick object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)moreBtnDidClick{
    [YJReaderEasyPopView removeEasyPopViewWithAnimation:YES];
    [YJReaderMorePopView readerMorePopView];
}




@end
