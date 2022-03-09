//
//  NSMutableDictionary+Category.m
//  runtime
//
//  Created by 舒通 on 2022/3/9.
//

#import "NSMutableDictionary+Category.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (Category)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls1 = NSClassFromString(@"__NSDictionaryM"); //可变字典
        Method method1 = class_getInstanceMethod(cls1, @selector(setObject:forKey:));
        Method method2 = class_getInstanceMethod(cls1, @selector(st_setObject:forKey:));
        method_exchangeImplementations(method1, method2);
    });
}
- (void)st_setObject:(id)anObject forKey:(id<NSCopying>)aKey{
    
    if (!aKey) {
        NSLog(@"字典中%@中值为%@的key为nil",self,anObject);
        return;
    }
    [self st_setObject:anObject forKey:aKey];
}
@end
