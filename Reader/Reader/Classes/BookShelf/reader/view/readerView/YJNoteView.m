//
//  YJNoteView.m
//  Reader
//
//  Created by Yang on 2020/7/1.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJNoteView.h"

@interface YJNoteView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray * dataArr;
@property (nonatomic, copy) titleDidClicked action;
@end

YJNoteView * bgNoteView;
UITableView * tableNoteView;

@implementation YJNoteView

+ (void)initWithFrame:(CGRect)frame datas:(NSArray *)datas action:(void (^)(NSString *))block{
    //添加朦板
    UIWindow *win = [[[UIApplication sharedApplication] windows] firstObject];
    //将朦板
    bgNoteView = [[YJNoteView alloc] initWithFrame:CGRectMake(0, 0, win.bounds.size.width, win.bounds.size.height - YJTabBarHeight)];
    bgNoteView.dataArr = datas;
    bgNoteView.action = block;
    bgNoteView.backgroundColor = [UIColor colorWithHue:0
                                        saturation:0
                                        brightness:0
                                             alpha:0.1];
    [win addSubview:bgNoteView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundClick)];
    [bgNoteView addGestureRecognizer:tap];
    
    tableNoteView = [[UITableView alloc] initWithFrame:CGRectMake(YJScreenWidth - 80, YJNavBarHeight - 20.0 * datas.count, frame.size.width, 40 * datas.count) style:0];
    tableNoteView.dataSource = bgNoteView;
    tableNoteView.delegate = bgNoteView;
    tableNoteView.layer.cornerRadius = 10.0f;
    tableNoteView.layer.anchorPoint = CGPointMake(1.0, 0);
    tableNoteView.transform =CGAffineTransformMakeScale(0.0001, 0.0001);
    tableNoteView.rowHeight = 40;
    [win addSubview:tableNoteView];
    
    [self show];
}
+(void)show{
    bgNoteView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        bgNoteView.alpha = 0.5;
        tableNoteView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}
+(void)cancelPopView{
    if (bgNoteView != nil) {
        tableNoteView.transform = CGAffineTransformMakeScale(0.000001, 0.0001);
        [bgNoteView removeFromSuperview];
        [tableNoteView removeFromSuperview];
        tableNoteView = nil;
        bgNoteView = nil;
    }
}

+(void)cancelPopViewWithAnimatioin{
    
    [UIView animateWithDuration:0.3 animations:^{
        tableNoteView.transform = CGAffineTransformMakeScale(0.000001, 0.0001);
    } completion:^(BOOL finished) {
        [bgNoteView removeFromSuperview];
        [tableNoteView removeFromSuperview];
        tableNoteView = nil;
        bgNoteView = nil;
    }];
}
+(void)tapBackgroundClick{
    [YJNoteView cancelPopViewWithAnimatioin];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
static NSString *Identifier = @"noteCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:Identifier];
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.action) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.action(cell.textLabel.text);
    }
}
@end
