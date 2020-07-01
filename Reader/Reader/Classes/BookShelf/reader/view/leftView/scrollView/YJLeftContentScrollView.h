//
//  YJLeftContentScrollView.h
//  Reader
//
//  Created by Yang on 2020/6/26.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJLeftTopView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJLeftContentScrollView : UIScrollView <YJLeftTopViewDelegate>
-(void)updateAllTableView:(NSArray *)chapters;
-(void)updateChapterTableView:(NSArray *)chapters;
@end

NS_ASSUME_NONNULL_END
