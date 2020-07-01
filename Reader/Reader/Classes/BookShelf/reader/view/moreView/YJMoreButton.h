//
//  YJMoreButton.h
//  Reader
//
//  Created by Yang on 2020/6/25.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJMoreButton : UIView
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *label;
+(instancetype)createMoreButton;

@end

NS_ASSUME_NONNULL_END
