//
//  YJTagNavView.h
//  Reader
//
//  Created by Yang on 2020/6/17.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol YJTagNavViewDelegate <NSObject>

@required
-(void)hasBtnDidClick:(NSInteger)index;

@end
@interface YJTagNavView : UIView
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
-(void)selectBtnWithTag:(NSInteger)tag;
@property (nonatomic, weak) id<YJTagNavViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
