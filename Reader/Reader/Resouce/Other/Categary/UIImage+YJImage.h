//
//  UIImage+YJImage.h
//  Reader
//
//  Created by Yang on 2020/6/10.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YJImage)
+(UIImage *)originImageWithName:(NSString *)imageName;
+(UIImage*)imageWithColor:(UIColor*) color;
@end

NS_ASSUME_NONNULL_END
