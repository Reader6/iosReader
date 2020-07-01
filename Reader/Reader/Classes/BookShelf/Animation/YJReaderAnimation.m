//
//  YJPushAnimation.m
//  Reader
//
//  Created by Yang on 2020/6/20.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJReaderAnimation.h"


@interface YJReaderAnimation ()

@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, assign) CGRect startRect;
@end

@implementation YJReaderAnimation


- (instancetype)initWithindexPath:(NSIndexPath *)indexPath
{
    self = [super init];
    if (self) {
        self.indexPath = indexPath;
    }
    return self;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    _startRect = [self.pushDelegate startRect:_indexPath];
    _imageView = [self.pushDelegate imageView:_indexPath];
    
    _isPush ? [self push:transitionContext] : [self pop:transitionContext];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 2.f;
}

-(void)push:(nonnull id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView* toView =  toVc.view;
    [[transitionContext containerView]  addSubview:toView];

    [[transitionContext containerView]  addSubview:_imageView];
    _imageView.frame = _startRect;
    NSTimeInterval timeInterVal = [self transitionDuration:transitionContext];
        
    toView.alpha = 0.0;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:timeInterVal animations:^{
        weakSelf.imageView.frame = [UIScreen mainScreen].bounds;
    } completion:^(BOOL finished) {
        [weakSelf.imageView removeFromSuperview];
        toView.alpha = 1.0;
        [transitionContext completeTransition:YES];
    }];
}
-(void)pop:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView* toView =  toVc.view;
    UIView* fromView = fromVc.view;
    
    [[transitionContext containerView]  addSubview:fromView];
    [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
    
    [[transitionContext containerView]  addSubview:_imageView];
    NSTimeInterval timeInterVal = [self transitionDuration:transitionContext];
    _imageView.frame = [UIScreen mainScreen].bounds;
    
    __weak typeof(self) weakSelf = self;
    
    [self.pushDelegate animationReloadData];
    [UIView animateWithDuration:timeInterVal animations:^{
        weakSelf.imageView.frame = weakSelf.startRect;
    } completion:^(BOOL finished) {
        [weakSelf.imageView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
}

@end
