//
//  YJDisplayViewController.h
//  Reader
//
//  Created by Yang on 2020/6/26.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class YJDisplayViewController;
@class YJReadItem;
@class YJReadView;


@protocol YJDisplayViewControllerDelegate <NSObject>
-(void)readViewEditeding:(YJDisplayViewController *)readView;
-(void)readViewEndEdit:(YJDisplayViewController *)readView;
@end
@interface YJDisplayViewController : UIViewController
@property (nonatomic,strong) NSString *content; //显示的内容
@property (nonatomic,strong) YJReadView *readView;
@property (nonatomic,weak) id<YJDisplayViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
