//
//  YJProfileCollectionViewCell.m
//  Reader
//
//  Created by Yang on 2020/6/11.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJProfileCollectionViewCell.h"
#import "UIImage+YJImage.h"

@interface YJProfileCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end


@implementation YJProfileCollectionViewCell

+ (YJProfileCollectionViewCell *)profileCollectionViewCell
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:NULL].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_btn setTintColor:[UIColor blackColor]];
}

- (void)setModel:(NSDictionary *)model
{
    _model = model;
    [_btn setTitle:model[@"title"] forState:UIControlStateNormal];
    [_btn setImage:[UIImage originImageWithName:model[@"image"]] forState:UIControlStateNormal];
}

@end
