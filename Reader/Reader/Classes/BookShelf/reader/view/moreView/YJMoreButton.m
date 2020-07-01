//
//  YJMoreButton.m
//  Reader
//
//  Created by Yang on 2020/6/25.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJMoreButton.h"


@interface YJMoreButton ()

@end

@implementation YJMoreButton

+(instancetype)createMoreButton{    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].firstObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.label.textColor = UIColorFromHex(0x6d6d6d);
}

@end
