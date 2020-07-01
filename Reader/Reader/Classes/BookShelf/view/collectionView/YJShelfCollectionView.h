//
//  YJShelfCollectionView.h
//  Reader
//
//  Created by Yang on 2020/6/20.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJReaderAnimation.h"

NS_ASSUME_NONNULL_BEGIN
@class YJShelfCollectionView;
typedef void(^cellDidClick)(YJShelfCollectionView * ,NSIndexPath *);

@interface YJShelfCollectionView : UICollectionView <AnimationDelegate>
-(instancetype)initCollectionViewWith:(CGRect)frame
                               dataArr:(NSArray *)dataArr
                           didSelected:(cellDidClick)cell;
@end

NS_ASSUME_NONNULL_END
