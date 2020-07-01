//
//  YJLeftTopScrollView.h
//  Reader
//
//  Created by Yang on 2020/6/26.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YJLeftTopViewDelegate <NSObject>

@required
-(void)hasBtnDidClick:(NSInteger)index;

@end

@interface YJLeftTopView : UIView
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
@property (nonatomic, weak) id<YJLeftTopViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
