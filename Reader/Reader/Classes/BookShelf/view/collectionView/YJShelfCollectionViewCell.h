//
//  YJShelfCollectionViewCell.h
//  Reader
//
//  Created by Yang on 2020/6/20.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJShelflItem;
NS_ASSUME_NONNULL_BEGIN

@interface YJShelfCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) YJShelflItem * item;
@end

NS_ASSUME_NONNULL_END
