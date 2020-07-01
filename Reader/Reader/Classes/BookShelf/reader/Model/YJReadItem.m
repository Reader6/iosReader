//
//  YJReadItem.m
//  textReader
//
//  Created by Yang on 2020/6/27.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJReadItem.h"
#import "YJChapterItem.h"

@implementation YJReadItem
-(instancetype)initWithContent:(NSString *)content
{
    self = [super init];
    if (self) {
        _content = content;
        //分离章节
        _chapters = [self separateChapterWithContent:content];
    }
    return self;
}
///分离章节
-(NSArray<YJChapterItem *> *)separateChapterWithContent:(NSString *)content
{
    NSMutableArray<YJChapterItem *> *temp = [NSMutableArray array];
    NSString *parten = @"第[0-9一二三四五六七八九十百千]*[章回].*";
    NSError* error = NULL;
    //正则表达式
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:NSRegularExpressionCaseInsensitive error:&error];
    //通过正则表达式过滤数据
    NSArray* match = [reg matchesInString:content options:NSMatchingReportCompletion range:NSMakeRange(0, [content length])];

    if(match.count != 0){
        __block NSRange nextRange = NSMakeRange(0, 0);
        [match enumerateObjectsUsingBlock:^(NSTextCheckingResult *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [obj range];
            NSInteger local = range.location;
            
            if (idx == 0) {
                if (match.count == 0) {
                    YJChapterItem *model = [[YJChapterItem alloc] init];
                    model.title = [content substringWithRange:range];
                    model.content = [content substringWithRange:NSMakeRange(local, content.length-local)];
                    [temp addObject:model];
                }else{
                    nextRange = [match[idx + 1] range];
                    YJChapterItem *model = [[YJChapterItem alloc] init];
                    model.title = [content substringWithRange:range];
                    NSUInteger len = nextRange.location;
                    model.content = [content substringWithRange:NSMakeRange(0, len)];
                    [temp addObject:model];
                }
                
            }else if (idx > 0  && idx < match.count - 1) {
                nextRange = [match[idx + 1] range];
                YJChapterItem *model = [[YJChapterItem alloc] init];
                model.title = [content substringWithRange:range];
                NSUInteger len = nextRange.location - local;
                model.content = [content substringWithRange:NSMakeRange(range.location, len)];
                [temp addObject:model];
            }else{
                YJChapterItem *model = [[YJChapterItem alloc] init];
                model.title = [content substringWithRange:range];
                model.content = [content substringWithRange:NSMakeRange(local, content.length-local)];
                [temp addObject:model];
            }
        }];
    }
    return [temp copy];
}
@end
