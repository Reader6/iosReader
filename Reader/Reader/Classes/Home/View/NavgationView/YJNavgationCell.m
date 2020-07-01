//
//  YJNavgationCell.m
//  Reader
//
//  Created by Yang on 2020/6/16.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJNavgationCell.h"

@interface YJNavgationCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation YJNavgationCell
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    NSString *imageName = dict[@"imageName"];
    _imageView.image = [UIImage imageNamed:imageName];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _label.text = dict[@"title"];
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

@end
