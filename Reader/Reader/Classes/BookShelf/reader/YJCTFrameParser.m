//
//  YJCTFrameParser.m
//  textReader
//
//  Created by Yang on 2020/6/27.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJCTFrameParser.h"
#import "YJReadConfig.h"



@implementation YJCTFrameParser

+(CTFrameRef)parserContent:(NSString *)content withFrame:(CGRect)frame
{

    
    CGRect bounds = CGRectMake(0, 0, YJScreenWidth - 40, YJScreenHeight - YJBottomSafeHeight - 44);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    
    NSDictionary *attribute = [self parserAttribute];
    
    [attributedString setAttributes:attribute range:NSMakeRange(0, content.length)];
    
    
    CTFramesetterRef setterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    
    CGPathRef pathRef = CGPathCreateWithRect(bounds, NULL);
    
    CTFrameRef frameRef = CTFramesetterCreateFrame(setterRef, CFRangeMake(0, 0), pathRef, NULL);
    
    CFRelease(setterRef);
    
    CFRelease(pathRef);
    
    return frameRef;
    
}

+(NSDictionary *)parserAttribute
{
    YJReadConfig *config = [YJReadConfig shareInstance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = config.fontColor;
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:config.fontSize];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = config.lineSpace;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    dict[NSParagraphStyleAttributeName] = paragraphStyle;
    return [dict copy];
}



+(CGRect)parserRectWithPoint:(CGPoint)point frameRef:(CTFrameRef)frameRef withSeletedRange:(NSRange *)seletRange withcontent:(NSString *)content withHeight:(NSInteger *)num{
    //frameRef 从中拿到path
    CGPathRef pathRef = CTFrameGetPath(frameRef);
    //frameRef 从中拿到bounds
    CGRect bounds = CGPathGetBoundingBox(pathRef);
    
    
    CGRect rect = CGRectZero;
    //获得该frameRef上的所有行
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frameRef);
    //空页
    if (!lines) {
        return rect;
    }
    
    NSInteger lineCount = [lines count];
    
    CGPoint *origins = malloc(lineCount * sizeof(CGPoint)); //给每行的起始点开辟内存
    
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), origins);
  
    if (lineCount) {
        //从CFRangeMake(0, 0)开始，获取每一行的Range
        CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), origins);

        for (int i = 0; i<lineCount; i++) {
            CGPoint baselineOrigin = origins[i];
            //遍历每一行
            CTLineRef line = (__bridge CTLineRef)[lines objectAtIndex:i];

            CGFloat ascent,descent,linegap; //声明字体的上行高度和下行高度和行距
            //获得一排文字的上行高度和下行高度和行距
            CGFloat lineWidth = CTLineGetTypographicBounds(line, &ascent, &descent, &linegap);
            //获得line的frame
            CGRect lineFrame = CGRectMake(baselineOrigin.x, CGRectGetHeight(bounds)-baselineOrigin.y-ascent, lineWidth, ascent+descent+linegap+[YJReadConfig shareInstance].lineSpace);
//            NSLog(@"%@",NSStringFromCGRect(lineFrame));
            
            if (CGRectContainsPoint(lineFrame,point)){
                //获取line中文字在整段文字中的Range
                CFRange stringRange = CTLineGetStringRange(line);
                //获取line上的run
                CFArrayRef runs = CTLineGetGlyphRuns(line);
                CTRunRef rundef = (CTRunRef)CFArrayGetValueAtIndex(runs,0);
                CFRange runRange =  CTRunGetStringRange(rundef);
                NSString * string = [content substringWithRange:NSMakeRange(runRange.location, runRange.length)];
                NSUInteger index = 0;
                CGSize sizeToFit = CGSizeZero;
                if ([string containsString:@" "]) {
                    index = [self handleString:string];
                    NSString * space = [string substringWithRange:NSMakeRange(0, index)];
                    sizeToFit = [space sizeWithFont:[UIFont systemFontOfSize:[YJReadConfig shareInstance].fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 10) lineBreakMode:NSLineBreakByWordWrapping];
                }
                *seletRange = NSMakeRange(stringRange.location + index, stringRange.length - index);
                rect = CGRectMake(lineFrame.origin.x + sizeToFit.width ,baselineOrigin.y - descent ,lineWidth - sizeToFit.width, ascent+descent);
                
                *num = baselineOrigin.y - lineFrame.origin.y;
                break;
            }

        }
    }
    return rect;
}
+(NSUInteger)handleString:(NSString *)string{
    int index = 0;
    for(int i = 0; i < string.length; i++){
        char spnb = ' ';
        char result = [string characterAtIndex:i];

        if (spnb == result) {
            index++;
        }
    }
    return index;
}
@end
