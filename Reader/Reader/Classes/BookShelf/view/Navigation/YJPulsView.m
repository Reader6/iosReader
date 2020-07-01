//
//  YJPulsView.m
//  Reader
//
//  Created by Yang on 2020/6/19.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJPulsView.h"

CGFloat margin = 23;
@interface YJPulsView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray * dataArr;
@property (nonatomic, copy) titleDidClicked action;
@end


YJPulsView * bgView;
UITableView * tableView;

@implementation YJPulsView


- (void)drawRect:(CGRect)rect {
    //设置背景色
    [[UIColor whiteColor] set];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);

    //绘制三个点
    CGContextMoveToPoint(context, YJScreenWidth - margin, YJNavBarHeight);
    
    CGContextAddLineToPoint(context, YJScreenWidth - margin - 12.5, YJNavBarHeight - 10);
    
    CGContextAddLineToPoint(context, YJScreenWidth - margin - 25, YJNavBarHeight);
    
    CGContextClosePath(context);
    
    //填充色
    [[UIColor whiteColor] setFill];
    
    //边框色
    [[UIColor whiteColor] setStroke];
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    [self setNeedsDisplay];
}

+ (void)initWithFrame:(CGRect)frame datas:(NSArray *)datas action:(void (^)(NSString *))block{
    //添加朦板
    UIWindow *win = [[[UIApplication sharedApplication] windows] firstObject];
    //将朦板
    bgView = [[YJPulsView alloc] initWithFrame:CGRectMake(0, 0, win.bounds.size.width, win.bounds.size.height - YJTabBarHeight)];
    bgView.dataArr = datas;
    bgView.action = block;
    bgView.backgroundColor = [UIColor colorWithHue:0
                                        saturation:0
                                        brightness:0
                                             alpha:0.1];
    [win addSubview:bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundClick)];
    [bgView addGestureRecognizer:tap];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(YJScreenWidth - 80, YJNavBarHeight - 20.0 * datas.count, frame.size.width, 40 * datas.count) style:0];
    tableView.dataSource = bgView;
    tableView.delegate = bgView;
    tableView.layer.cornerRadius = 10.0f;
    tableView.layer.anchorPoint = CGPointMake(1.0, 0);
    tableView.transform =CGAffineTransformMakeScale(0.0001, 0.0001);
    tableView.rowHeight = 40;
    [win addSubview:tableView];
    
    [self show];
}

+(void)show{
    bgView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        bgView.alpha = 0.5;
        tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}
+(void)cancelPopView{
    if (bgView != nil) {
        tableView.transform = CGAffineTransformMakeScale(0.000001, 0.0001);
        [bgView removeFromSuperview];
        [tableView removeFromSuperview];
        tableView = nil;
        bgView = nil;
    }
}
+(void)cancelPopViewWithAnimatioin{
    
    [UIView animateWithDuration:0.3 animations:^{
        tableView.transform = CGAffineTransformMakeScale(0.000001, 0.0001);
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
        [tableView removeFromSuperview];
        tableView = nil;
        bgView = nil;
    }];
}

+(void)tapBackgroundClick{
    [YJPulsView cancelPopViewWithAnimatioin];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
static NSString *Identifier = @"pulsCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:Identifier];
    }
    NSDictionary *dict = _dataArr[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.imageView.image = [UIImage imageNamed:dict[@"imageName"]];
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
