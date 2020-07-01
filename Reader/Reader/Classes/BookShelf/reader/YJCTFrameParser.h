//
//  YJCTFrameParser.h
//  textReader
//
//  Created by Yang on 2020/6/27.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
NS_ASSUME_NONNULL_BEGIN

@interface YJCTFrameParser : NSObject
+(CTFrameRef)parserContent:(NSString *)content withFrame:(CGRect)frame;
+(NSDictionary *)parserAttribute;
+(CGRect)parserRectWithPoint:(CGPoint)point frameRef:(CTFrameRef)frameRef withSeletedRange:(NSRange *)seletRange withcontent:(NSString *)content withHeight:(NSInteger *)num;
@end

NS_ASSUME_NONNULL_END
