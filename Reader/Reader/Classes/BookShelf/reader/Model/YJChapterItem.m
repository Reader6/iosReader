//
//  YJChapterItem.m
//  textReader
//
//  Created by Yang on 2020/6/26.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJChapterItem.h"
#import "YJReadConfig.h"
#import "YJCTFrameParser.h"
#import <CoreText/CoreText.h>

@implementation YJChapterItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageArray = [NSMutableArray array];
    }
    return self;
}


-(void)setContent:(NSString *)content
{
    _content = content;

    CGFloat topHeight = YJIsIphoneX ? 44 : 0;
    [self paginateWithBounds:CGRectMake(0, 0, YJScreenWidth - 40, YJScreenHeight - YJBottomSafeHeight - topHeight)];
}
///分离章至页
-(void)paginateWithBounds:(CGRect)bounds{
    [_pageArray removeAllObjects];
    
    //创建富文本
    NSMutableAttributedString *attrString = [[NSMutableAttributedString  alloc] initWithString:self.content];
    NSDictionary *attribute = [YJCTFrameParser parserAttribute];
    [attrString setAttributes:attribute range:NSMakeRange(0, attrString.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) attrString);
    
    //创建一个不可变的矩形路径
    CGPathRef path = CGPathCreateWithRect(bounds, NULL);
    int currentOffset = 0;
    int currentInnerOffset = 0;
    BOOL hasMorePages = YES;
    
    // 防止死循环，如果在同一个位置获取CTFrame超过2次，则跳出循环
    int preventDeadLoopSign = currentOffset;
    int samePlaceRepeatCount = 0;
    
    while (hasMorePages) {
        if (preventDeadLoopSign == currentOffset) {
            ++samePlaceRepeatCount;
        } else {
            samePlaceRepeatCount = 0;
        }
        if (samePlaceRepeatCount > 1) {
            // 退出循环前检查一下最后一页是否已经加上
            if (_pageArray.count == 0) {
                [_pageArray addObject:@(currentOffset)];
            }
            else {
                NSUInteger lastOffset = [[_pageArray lastObject] integerValue];
                if (lastOffset != currentOffset) {
                    [_pageArray addObject:@(currentOffset)];
                }
            }
            break;
        }
        [_pageArray addObject:@(currentOffset)];
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(currentInnerOffset, 0), path, NULL);
        //获取真正在frame适应的字符的range
        CFRange range = CTFrameGetVisibleStringRange(frame);
        
        if ((range.location + range.length) != attrString.length) {
            currentOffset += range.length;
            currentInnerOffset += range.length;
        } else {
            // 已经分完，提示跳出循环
            hasMorePages = NO;
        }
        if (frame) CFRelease(frame);
    }
    CGPathRelease(path);
    CFRelease(frameSetter);
    _pageCount = _pageArray.count;
}


-(NSString *)stringOfPage:(NSUInteger)index
{
    //_pageArray = @[@0, @20, @30,...];
    NSUInteger local = [_pageArray[index] integerValue];
    NSUInteger length;
   
    if (index < self.pageCount - 1) {
        
        length=  [_pageArray[index + 1] integerValue] - [_pageArray[index] integerValue];
    }
    else{
        length = _content.length - [_pageArray[index] integerValue];
    }
    return [_content substringWithRange:NSMakeRange(local, length)];
}
@end
