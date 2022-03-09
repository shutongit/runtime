//
//  UIControl+Category.m
//  runtime
//
//  Created by 舒通 on 2022/3/9.
//

#import "UIControl+Category.h"
#import <objc/runtime.h>

@implementation UIControl (Category)
+ (void)load {
//    hook:钩子函数
    Method method1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:)); // 原始方法
    Method method2 = class_getInstanceMethod(self, @selector(st_sendAction:to:forEvent:)); /// 要替代的新方法
    
    method_exchangeImplementations(method1, method2);// 替换方法
}
- (void)st_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([self isKindOfClass:[UIButton class]]) { //因为继承UIControl的有很多
        NSLog(@"我是替换过的button方法");
    }
    
    // 实现完自己的方法之后 要继续执行系统的方法，因为方法已经替换过了，所以执行系统方法 就是执行自己的方法
    [self st_sendAction:action to:target forEvent:event];
}

@end
