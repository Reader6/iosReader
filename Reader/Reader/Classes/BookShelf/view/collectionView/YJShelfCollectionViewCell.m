//
//  YJShelfCollectionViewCell.m
//  Reader
//
//  Created by Yang on 2020/6/20.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJShelfCollectionViewCell.h"
#import "YJShelflItem.h"

@interface YJShelfCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation YJShelfCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRed:230 green:230 blue:230 alpha:1].CGColor;
}

- (void)setItem:(YJShelflItem *)item{
    _imageView.image = [UIImage imageNamed:item.image];
}
@end
