//
//  YJNoteView.h
//  Reader
//
//  Created by Yang on 2020/7/1.
//  Copyright © 2020 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^titleDidClicked)(NSString *) ;
@interface YJNoteView : UIView
+ (void)initWithFrame:(CGRect)frame datas:(NSArray *)datas action:(titleDidClicked)block;
+(void)cancelPopView;
@end

NS_ASSUME_NONNULL_END
