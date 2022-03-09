//
//  UITextView+placeHold.m
//  runtime
//
//  Created by 舒通 on 2022/3/9.
//

#import "UITextView+placeHold.h"
#import <objc/runtime.h>

@implementation UITextView (placeHold)

+ (void)load
{
    
    [self hookOrigInstanceMethod:@selector(init) newInstanceMethod:@selector(yl_init)];
    [self hookOrigInstanceMethod:@selector(setText:) newInstanceMethod:@selector(yl_setText:)];
    [self hookOrigInstanceMethod:@selector(setAttributedText:) newInstanceMethod:@selector(yl_setAttributedText:)];
    [self hookOrigInstanceMethod:@selector(setFont:) newInstanceMethod:@selector(yl_setFont:)];
    [self hookOrigInstanceMethod:@selector(setTextAlignment:) newInstanceMethod:@selector(yl_setTextAlignment:)];
}
+ (BOOL)hookOrigInstanceMethod:(SEL)oriSEL newInstanceMethod:(SEL)swizzledSEL
{
    Class cls = self;
    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    Method swiMethod = class_getInstanceMethod(cls, swizzledSEL);
    
    if (!swiMethod) {
        return NO;
    }
    
    if (!oriMethod) {
        class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
        method_setImplementation(swiMethod, imp_implementationWithBlock(^(id self, SEL _cmd){ }));
    }
    
    BOOL didAddMethod = class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, swiMethod);
    }
    
    return YES;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (instancetype)yl_init
{
    // self 报错 Cannot assign to 'self' outside of a method in the init family
    id ylSelf = [self yl_init];
    if (ylSelf) {
        self.font = [UIFont systemFontOfSize:16];
        self.placeHolderColor = [UIColor lightGrayColor];
        self.placeHolder = nil;
        [self _addTextViewNotificationObservers];
    }
    return ylSelf;
}

- (void)yl_setText:(NSString *)text
{
    [self yl_setText:text];
    [self setNeedsDisplay];
}

- (void)yl_setAttributedText:(NSAttributedString *)attributedText
{
    [self yl_setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)yl_setFont:(UIFont *)font
{
    [self yl_setFont:font];
    [self setNeedsDisplay];
}

- (void)yl_setTextAlignment:(NSTextAlignment)textAlignment
{
    [self yl_setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}
#pragma mark - Draw

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if ([self.text length] == 0 && self.placeHolder) {
        [self.placeHolderColor set];
        [self.placeHolder drawInRect:CGRectInset(rect, 7.0f, 7.5f) withAttributes:[self _placeHolderTextAttributes]];
    }
}

#pragma mark - Notifications
- (void)_addTextViewNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:self];
}

- (void)_didReceiveTextViewNotification:(NSNotification *)notification
{
    [self setNeedsDisplay];
}

- (void)_removeTextViewNotificationObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidBeginEditingNotification
                                                  object:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidEndEditingNotification
                                                  object:self];

}

- (NSDictionary *)_placeHolderTextAttributes
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = self.textAlignment;
    
    return @{
        NSFontAttributeName: self.font?self.font:[UIFont systemFontOfSize:16],
        NSForegroundColorAttributeName: self.placeHolderColor,
        NSParagraphStyleAttributeName: paragraphStyle
    };
}

- (void)dealloc
{
    [self _removeTextViewNotificationObservers];
}


// 添加属性
- (NSString *)placeHolder {
    return  objc_getAssociatedObject(self, @selector(placeholder));
}
- (void)setPlaceHolder:(NSString *)placeHolder {
    NSString *_placeHolder = objc_getAssociatedObject(self, @selector(placeholder));
    if ([_placeHolder isEqualToString:placeHolder]) {
        return;
    }
    objc_setAssociatedObject(self, @selector(placeholder), placeHolder, OBJC_ASSOCIATION_COPY);
}
- (UIColor *)placeHolderColor {
    UIColor *_placeHolderColor = objc_getAssociatedObject(self, @selector(placeHolderColor));
    if (_placeHolderColor == nil) {
        _placeHolderColor = [UIColor lightGrayColor];
    }
    return _placeHolderColor;
}
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    UIColor *_placeHolderColor = objc_getAssociatedObject(self, @selector(placeHolderColor));
    if (CGColorEqualToColor(_placeHolderColor.CGColor, placeHolderColor.CGColor)) {
        return;
    }
    objc_setAssociatedObject(self, @selector(placeHolderColor), placeHolderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
