//
//  UIImage+YJImage.m
//  Reader
//		//  Created by Yang on 2020/6/10.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "UIImage+YJImage.h"

@implementation UIImage (YJImage)


#pragma mark - 展示图标本色
+(UIImage *)originImageWithName:(NSString *)imageName
{
    UIImage* image = [UIImage imageNamed:imageName];
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;
}

+(UIImage*)imageWithColor:(UIColor*) color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
