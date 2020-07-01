//
//  YJChapterItem.h
//  textReader
//
//  Created by Yang on 2020/6/26.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJChapterItem : NSObject
@property (nonatomic,strong) NSMutableArray *pageArray;

@property (nonatomic,strong) NSString *content;

@property (nonatomic,strong) NSString *title;

@property (nonatomic) NSUInteger pageCount;



-(NSString *)stringOfPage:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
