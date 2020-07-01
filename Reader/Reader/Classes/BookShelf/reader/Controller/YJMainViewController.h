//
//  YJMainViewController.h
//  Reader
//
//  Created by Yang on 2020/6/25.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YJReadItem;

@interface YJMainViewController : UIViewController
-(instancetype)initWithModel:(YJReadItem *)model;
@end

NS_ASSUME_NONNULL_END
