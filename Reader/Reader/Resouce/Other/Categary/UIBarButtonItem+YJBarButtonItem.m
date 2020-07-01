//
//  UIBarButtonItem+YJBarButtonItem.m
//  Reader
//
//  Created by Yang on 2020/6/11.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "UIBarButtonItem+YJBarButtonItem.h"
#import "UIImage+YJImage.h"
@implementation UIBarButtonItem (YJBarButtonItem)
+(instancetype)btnWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage originImageWithName:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage originImageWithName:[NSString stringWithFormat:@"%@_highlighted", imageName]] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return btnItem;
}

+(UIBarButtonItem *)btnWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromHex(0xd75f53) forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = UIColorFromHex(0xd75f53).CGColor;
    btn.layer.cornerRadius = 10;
    [btn.layer masksToBounds];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return btnItem;
}
@end
