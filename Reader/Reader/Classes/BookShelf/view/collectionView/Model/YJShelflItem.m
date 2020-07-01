//
//  YJShelflItem.m
//  Reader
//
//  Created by Yang on 2020/6/20.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJShelflItem.h"

@implementation YJShelflItem
-(instancetype)initWithDict:(NSDictionary *)dict{
    YJShelflItem *item = [[YJShelflItem alloc] init];
    item.name = dict[@"name"];
    item.image = dict[@"image"];
    return item;
}
@end
