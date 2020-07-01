//
//  YJDisplayViewController.m
//  Reader
//
//  Created by Yang on 2020/6/26.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJDisplayViewController.h"
#import "YJReadItem.h"
#import "YJReadView.h"
#import "YJReadConfig.h"
#import "YJCTFrameParser.h"
#import "YJReadConfig.h"

@interface YJDisplayViewController ()

@end

@implementation YJDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [YJReadConfig shareInstance].theme;
   [self.view addSubview:self.readView];
    
    
}

-(YJReadView *)readView
{
    if (!_readView) {
        
        CGFloat topHeight = YJIsIphoneX ? 44 : 0;
        
        CGRect frame = CGRectMake(20, topHeight, YJScreenWidth - 40, YJScreenHeight - YJBottomSafeHeight-topHeight);
        _readView = [[YJReadView alloc] initWithFrame: frame];
        _readView.frameRef = [YJCTFrameParser parserContent:_content withFrame:frame];
        _readView.content = _content;
    }
    return _readView;
}

-(void)readViewEditeding:(YJDisplayViewController *)readView
{
    if ([self.delegate respondsToSelector:@selector(readViewEditeding:)]) {
        [self.delegate readViewEditeding:self];
    }
}
-(void)readViewEndEdit:(YJDisplayViewController *)readView
{
    if ([self.delegate respondsToSelector:@selector(readViewEndEdit:)]) {
        [self.delegate readViewEndEdit:self];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
