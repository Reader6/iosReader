//
//  YJDetailScrollView.h
//  Reader
//
//  Created by Yang on 2020/6/17.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTagNavView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJDetailScrollView : UIScrollView <YJTagNavViewDelegate>
@property (nonatomic, weak) YJTagNavView * tagView;
@end

NS_ASSUME_NONNULL_END
