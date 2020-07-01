//
//  YJReaderMorePopView.m
//  Reader
//
//  Created by Yang on 2020/6/25.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJReaderMorePopView.h"
#import "YJMoreView.h"

@implementation YJReaderMorePopView
UIView *bgMoreView;
YJReaderMorePopView *morePopView;
CGFloat morePopViewHeight = 0;

+(void)readerMorePopView{
    UIWindow *win = [[[UIApplication sharedApplication] windows] firstObject];
    if (!bgMoreView) {
        bgMoreView = [[UIView alloc] initWithFrame:CGRectMake(0, YJNavBarHeight, YJScreenWidth, YJScreenHeight - YJNavBarHeight)];
        if (morePopView) {
            [win insertSubview:bgMoreView belowSubview:morePopView];
        }else{
            [win addSubview:bgMoreView];
        }
       
       UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundClick)];
       [bgMoreView addGestureRecognizer:tap];
    }
   
    
    if (!morePopView) {
        morePopViewHeight = YJScreenHeight * 0.4;
        morePopViewHeight = YJIsIphoneX ? (morePopViewHeight + YJBottomSafeHeight) : morePopViewHeight;
        morePopView = [[YJReaderMorePopView alloc] initWithFrame:CGRectMake(0, YJScreenHeight, YJScreenWidth, morePopViewHeight)];
        [win addSubview:morePopView];
        morePopView.backgroundColor = UIColorFromHex(0x595959);
    }
    
    [self show];
}


+(void)show{
    [UIView animateWithDuration:0.3 animations:^{
        morePopView.frame = CGRectMake(0, YJScreenHeight - morePopViewHeight, YJScreenWidth, morePopViewHeight);
    }];
}

+(void)removeMorePopView{
    if (morePopView != nil) {
        [UIView animateWithDuration:0.3 animations:^{
            morePopView.frame = CGRectMake(0, YJScreenHeight, YJScreenWidth, morePopViewHeight);
        } completion:^(BOOL finished) {
            [bgMoreView removeFromSuperview];
            bgMoreView = nil;
            morePopViewHeight = YJScreenHeight * 0.4;
        }];
    }
}

+(void)tapBackgroundClick{
    [self removeMorePopView];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        YJMoreView *moreView = [[YJMoreView alloc] initWithFrame:CGRectMake(0, 0, YJScreenWidth, morePopViewHeight)];
        [self addSubview:moreView];
    }
    return self;
}





@end
