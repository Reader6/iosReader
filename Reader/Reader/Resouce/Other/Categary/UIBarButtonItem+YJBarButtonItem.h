//
//  UIBarButtonItem+YJBarButtonItem.h
//  Reader
//
//  Created by Yang on 2020/6/11.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (YJBarButtonItem)
+(UIBarButtonItem *)btnWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;
+(UIBarButtonItem *)btnWithTitle:(NSString *)title target:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
