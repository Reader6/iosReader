//
//  YJReadConfig.m
//  textReader
//
//  Created by Yang on 2020/6/26.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJReadConfig.h"

@implementation YJReadConfig
+(instancetype)shareInstance
{
    static YJReadConfig *readConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        readConfig = [[self alloc] init];
    });
    return readConfig;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        //不在磁盘中
        _lineSpace = 14.0f;
        _fontSize = 14.0f;
        _fontColor = [UIColor blackColor];
        _theme = UIColorFromHex(0xe8e8e8);
    }
    return self;
}
-(void)setFontSize:(CGFloat)fontSize{
    _fontSize = fontSize;
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_configChange object:nil];
}

- (void)setTheme:(UIColor *)theme{
    _theme = theme;
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_configChange object:nil];
}
-(void)setLineSpace:(CGFloat)lineSpace{
    _lineSpace = lineSpace;
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_configChange object:nil];
}
@end
