//
//  YJShelfCollectionView.m
//  Reader
//
//  Created by Yang on 2020/6/20.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJShelfCollectionView.h"
#import "YJShelfCollectionViewCell.h"
#import "YJShelflItem.h"


CGFloat shelfMargin = 10;
CGFloat cellSpace = 15;
CGFloat lineSpacing = 20;
@interface YJShelfCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray * dataArr;
@property (nonatomic, copy) cellDidClick cellBlock;
@end

@implementation YJShelfCollectionView


static NSString * cellIdentifier = @"shelfCellIdentifier";

-(instancetype)initCollectionViewWith:(CGRect)frame dataArr:(nonnull NSArray *)dataArr didSelected:(nonnull cellDidClick)cell{
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (YJScreenWidth - 2 *shelfMargin - 2 * cellSpace) / 3;
    CGFloat height = width + 20;
    layout.itemSize = CGSizeMake(width, height);
    layout.minimumLineSpacing = lineSpacing;
    layout.minimumInteritemSpacing = cellSpace;

    YJShelfCollectionView *collectionView = [[YJShelfCollectionView alloc] initWithFrame:frame collectionViewLayout: layout];
    collectionView.dataArr = [self addDefaultImage: dataArr];
    collectionView.cellBlock = cell;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.dataSource = collectionView;
    collectionView.delegate = collectionView;
    [collectionView registerNib:[UINib nibWithNibName:@"YJShelfCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    collectionView.contentInset = UIEdgeInsetsMake(20, shelfMargin, 0, shelfMargin);
    return collectionView;
}

-(NSArray *)addDefaultImage:(NSArray *)array{
    NSMutableArray *arr = [NSMutableArray arrayWithArray: array];
    NSDictionary *dict = @{
        @"name" : @"empty",
        @"image" : @"Bgbook"
    };
    YJShelflItem *item = [[YJShelflItem alloc] initWithDict:dict];
    [arr addObject: item];
    return arr;
}



- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    YJShelfCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.item = _dataArr[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellBlock) {
        self.cellBlock(self ,indexPath);
    }
}


- (CGRect)startRect:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:indexPath];
    CGRect startFrame = [self convertRect:cell.frame toCoordinateSpace:[UIApplication sharedApplication].keyWindow];
    return startFrame;
}

- (nonnull UIImageView *)imageView:(nonnull NSIndexPath *)indexPath {
    YJShelflItem *item = _dataArr[indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:item.image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    return imageView;
}
-(void)animationReloadData{
    [self reloadData];
}

@end
