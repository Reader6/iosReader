//
//  YJShelflItem.h
//  Reader
//
//  Created by Yang on 2020/6/20.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJShelflItem : NSObject
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * image;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
