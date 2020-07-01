//
//  YJReadItem.h
//  textReader
//
//  Created by Yang on 2020/6/27.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YJChapterItem;

@interface YJReadItem : NSObject
@property (nonatomic,strong) NSURL *resource;

@property (nonatomic,copy) NSString *content;

@property (nonatomic,strong) NSArray <YJChapterItem *>*chapters;


-(instancetype)initWithContent:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
