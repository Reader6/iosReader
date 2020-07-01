//
//  YJProfileCollectionViewCell.h
//  Reader
//
//  Created by Yang on 2020/6/11.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJProfileCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSDictionary * model;
+(YJProfileCollectionViewCell *)profileCollectionViewCell;

@end

NS_ASSUME_NONNULL_END
