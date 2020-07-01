//
//  YJReadConfig.h
//  textReader
//
//  Created by Yang on 2020/6/26.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJReadConfig : NSObject
+(instancetype)shareInstance;
//字体大小
@property (nonatomic) CGFloat fontSize;
//行间距
@property (nonatomic) CGFloat lineSpace;
//字体颜色
@property (nonatomic,strong) UIColor *fontColor;
//主题颜色
@property (nonatomic,strong) UIColor *theme;
@end

NS_ASSUME_NONNULL_END
