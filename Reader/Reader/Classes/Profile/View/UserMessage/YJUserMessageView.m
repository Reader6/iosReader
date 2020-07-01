//
//  YJUserMessageView.m
//  Reader
//
//  Created by Yang on 2020/6/11.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJUserMessageView.h"

@implementation YJUserMessageView

+ (YJUserMessageView *)userMessageView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:NULL].lastObject;
}

@end
