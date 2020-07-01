//
//  YJPushAnimation.h
//  Reader
//
//  Created by Yang on 2020/6/20.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@protocol AnimationDelegate <NSObject>

@required
-(CGRect)startRect:(NSIndexPath *)indexPath;
-(UIImageView *)imageView:(NSIndexPath *)indexPath;
-(void)animationReloadData;

@end


@protocol AnimationPopDelegate <NSObject>

@required

@end

@interface YJReaderAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL isPush;
@property (nonatomic, weak) id<AnimationDelegate> pushDelegate;
-(instancetype)initWithindexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
