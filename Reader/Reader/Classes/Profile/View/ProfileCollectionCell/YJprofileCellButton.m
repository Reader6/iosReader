//
//  YJprofileCellButton.m
//  Reader
//
//  Created by Yang on 2020/6/11.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJprofileCellButton.h"

@implementation YJprofileCellButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat midX = self.frame.size.width / 2;
    CGFloat midY = self.frame.size.height/ 2 ;
    
    self.imageView.center = CGPointMake(midX, midY);
    CGFloat imageY = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.center = CGPointMake(midX, imageY + 15);
}

@end
