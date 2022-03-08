//
//  STPerson05.m
//  runtime
//
//  Created by 舒通 on 2022/3/8.
//

#import "STPerson05.h"
#import <objc/runtime.h>

@implementation STPerson05

+ (BOOL)resolveClassMethod:(SEL)sel { //动态解析类方法
    if (sel == @selector(classTest)) {
        Method method = class_getClassMethod(self, @selector(classOther));
//        object_getClass(self) / [self superclass]
        class_addMethod([self superclass], sel, method_getImplementation(method), method_getTypeEncoding(method));
        
        return YES;
    }
    
    return [super resolveClassMethod:sel];
}
+ (BOOL)resolveInstanceMethod:(SEL)sel { //动态解析实例方法
    if (sel == @selector(test)) {
        
        // 获取方法
        Method method = class_getInstanceMethod(self, @selector(other));
        
        // 动态添加test方法的实现 [self class] / self
        class_addMethod([self class], sel, method_getImplementation(method), method_getTypeEncoding(method));
        
        // 返回yes代表有动态添加
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
- (void)other {
    NSLog(@"%s", __func__);
}
+ (void)classOther {
    NSLog(@"%s", __func__);
}
@end
