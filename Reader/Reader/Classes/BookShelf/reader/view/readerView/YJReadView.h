//
//  YJReadView.h
//  textReader
//
//  Created by Yang on 2020/6/27.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
NS_ASSUME_NONNULL_BEGIN


@interface YJReadView : UIView
@property (nonatomic,assign) CTFrameRef frameRef;
@property (nonatomic,strong) NSString *content;
@end

NS_ASSUME_NONNULL_END
