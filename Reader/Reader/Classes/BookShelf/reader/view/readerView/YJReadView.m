//
//  YJReadView.m
//  textReader
//
//  Created by Yang on 2020/6/27.
//  Copyright © 2020 Yang. All rights reserved.
//

#import "YJReadView.h"
#import "YJMagnifierView.h"
#import "YJCTFrameParser.h"
#import "YJReadConfig.h"
#import "YJNoteView.h"



@interface YJReadView (){BOOL _direction;
    CGRect _menuRect;
    CGRect _rect;
    NSRange _selectRange;
    NSInteger _num;
}
@property (nonatomic,strong) YJMagnifierView *magnifierView;
@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) NSMutableArray * pathArray;
@property (nonatomic, strong) NSMutableArray * noteArray;
@property (nonatomic, strong) NSMutableArray  * notes;
@end

@implementation YJReadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [YJReadConfig shareInstance].theme;
        _pathArray = [NSMutableArray array];
        _noteArray = [NSMutableArray array];
        _notes = [NSMutableArray array];
        [self addGestureRecognizer:({
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPress;
        })];
        [self addGestureRecognizer:({
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
            tap;
        })];
        
    }
    return self;
}
-(void)tapView:(UITapGestureRecognizer *)tap{

    CGPoint point = [tap locationInView:self];
    
    if (CGRectContainsPoint(CGRectMake(_rect.origin.x, _rect.origin.y - _num, _rect.size.width, _rect.size.height), point)) {
        NSArray *arr = @[@"111111", @"22222", @"33333", @"4444", @"5555", @"6666", @"7777", @"88888", @"99999",];
        [YJNoteView initWithFrame:CGRectMake(point.x,  point.y, 100, 100) datas:arr action:^(NSString * title) {
            NSLog(@"点击了---%@",title);
        }];
    }else{
        [self hiddenMenu];
        if (_pathArray.count != 0) {
            [_pathArray removeAllObjects];
            [self setNeedsDisplay];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_showPopView object:nil];
    }
}
-(void)showMagnifier
{
    if (!_magnifierView) {
        self.magnifierView = [[YJMagnifierView alloc] init];
        self.magnifierView.readView = self;
        [self addSubview:self.magnifierView];
    }
}
-(void)hiddenMagnifier
{
    if (_magnifierView) {
        [self.magnifierView removeFromSuperview];
        self.magnifierView = nil;
    }
}


-(void)showMenu
{
    if ([self becomeFirstResponder]) {
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        UIMenuItem *menuItemCopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(menuCopy:)];
        UIMenuItem *menuItemNote = [[UIMenuItem alloc] initWithTitle:@"笔记" action:@selector(menuNote:)];
        UIMenuItem *menuItemShare = [[UIMenuItem alloc] initWithTitle:@"分享" action:@selector(menuShare:)];
        NSArray *menus = @[menuItemShare,menuItemCopy,menuItemNote];
        [menuController setMenuItems:menus];
        [menuController setTargetRect:CGRectMake(CGRectGetMidX(_menuRect), self.frame.size.height-CGRectGetMidY(_menuRect), CGRectGetHeight(_menuRect), CGRectGetWidth(_menuRect)) inView:self];
        [menuController setMenuVisible:YES animated:YES];
    }
        
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
-(void)menuCopy:(id)sender{
    [self hiddenMenu];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:[_content substringWithRange: _selectRange]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功复制以下内容" message:pasteboard.string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    
}
-(void)menuNote:(id)sender{
    [self hiddenMenu];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"笔记" message:[_content substringWithRange:_selectRange]  preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    NSString * temp = _pathArray.lastObject;
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"输入内容";
        weakSelf.textField = textField;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (weakSelf.textField.text.length != 0) {
            [weakSelf.noteArray addObject:temp];
            [weakSelf setNeedsDisplay];
            [weakSelf.notes addObject:weakSelf.textField.text];
        }
    }];
    [alertController addAction:cancel];
    [alertController addAction:confirm];
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            [(UIViewController *)nextResponder presentViewController:alertController animated:YES completion:nil];
            break;
        }
    }
   
    [_pathArray removeAllObjects];
    [self setNeedsDisplay];
    
}
-(void)menuShare:(id)sender{
    [self hiddenMenu];
}
-(void)hiddenMenu
{
     [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}
-(void)longPress:(UILongPressGestureRecognizer *)longPress
{
    
    //获取自己视图上点击的位置
    CGPoint point = [longPress locationInView:self];
    
    if (longPress.state == UIGestureRecognizerStateBegan){
        _rect = [YJCTFrameParser parserRectWithPoint:point frameRef:_frameRef withSeletedRange:&_selectRange  withcontent:_content withHeight:&_num];
        [self showMagnifier];
        self.magnifierView.touchPoint = point;
        if (!CGRectEqualToRect(_rect, CGRectZero)) {
            [_pathArray addObject:NSStringFromCGRect(_rect)];
            [self setNeedsDisplay];
        }
    }
    if (longPress.state == UIGestureRecognizerStateEnded) {
        [self hiddenMagnifier];
        if (!CGRectEqualToRect(_menuRect, CGRectZero)) {
            [self showMenu];
        }
    }
    
}


-(void)drawSelectedPath:(NSArray *)array{
    if (array.count == 0) {
        return;
    }
    CGMutablePathRef _path = CGPathCreateMutable();
    [[UIColor cyanColor] setFill];
    for (int i = 0; i < [array count]; i++) {
        CGRect rect = CGRectFromString([array objectAtIndex:i]);
        CGPathAddRect(_path, NULL, rect);
        if (i == 0) {
            _menuRect = rect;
        }
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, _path);
    CGContextFillPath(ctx);
    CGPathRelease(_path);
}

-(void)drawMarkForNote:(NSArray *)array{
    if (array.count == 0) {
        return;
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGMutablePathRef _path = CGPathCreateMutable();
    [[UIColor systemBlueColor] setFill];
    
    CGPathAddRect(_path, NULL, CGRectMake(_rect.origin.x, _rect.origin.y,_rect.size.width, 2));
    
    CGContextAddPath(ctx, _path);
    CGContextFillPath(ctx);
    CGPathRelease(_path);
    
    CGFloat dotSize = 15;
    CGContextDrawImage(ctx,CGRectMake(CGRectGetMaxX(_rect)-dotSize, CGRectGetMinY(_rect)-dotSize, dotSize, dotSize),[UIImage imageNamed:@"r_drag-dot"].CGImage);
}


-(void)drawRect:(CGRect)rect{
    if (!_frameRef) {
        return;
    }
    //改变坐标
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    _menuRect = CGRectZero;
    [self drawSelectedPath:_pathArray];
    CTFrameDraw(_frameRef, ctx);
    [self drawMarkForNote:_noteArray];
}

-(void)dealloc{
    if (_frameRef) {
        CFRelease(_frameRef);
        _frameRef = nil;
    }
}
-(void)setFrameRef:(CTFrameRef)frameRef
{
    if (_frameRef != frameRef) {
        if (_frameRef) {
            CFRelease(_frameRef);
            _frameRef = nil;
        }
        _frameRef = frameRef;
    }
}

@end
