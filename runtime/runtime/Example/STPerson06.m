//
//  STPerson06.m
//  runtime
//
//  Created by 舒通 on 2022/3/8.
//

#import "STPerson06.h"
#import "STCat06.h"

@implementation STPerson06

// 消息转发可以转发对象方法也可以转发实例方法


- (id)forwardingTargetForSelector:(SEL)aSelector { // 如果实现了转发方法 就不用实现方法签名和方法调用
    if (aSelector == @selector(test)) {
//        objv_msgSend([[STCat06 alloc] init], aSelector)
        return [[STCat06 alloc] init]; // 可以调用一个实例对象的同一个方法名的方法
    } else if (aSelector == @selector(setAge:)) {
        // 不实现，要执行 methodSignatureForSelector 和 forwardInvocation
    }
    return [super forwardingTargetForSelector:aSelector];
}

//方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(setAge:)) {
        NSMethodSignature *method = [NSMethodSignature signatureWithObjCTypes:"i@:i"]; // @"i@:i"表示：i返回int类型 @表示self : 表示_cmd i表示int类型参数
        return method;
    }
    return [super methodSignatureForSelector:aSelector];
}
//方法调用
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    // 在这个方法里 你可以做任何你想做的事情
    NSLog(@"%s",__func__);
    
    [anInvocation invokeWithTarget:[[STCat06 alloc]init]];
    
    // 获取值
    int ret;
    [anInvocation getReturnValue:&ret];
    
    NSLog(@"年龄：%d",ret);
}


//+ (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    // objc_msgSend([[MJCat alloc] init], @selector(test))
//    // [[[MJCat alloc] init] test]
//    if (aSelector == @selector(test)) return [[STCat06 alloc] init];
//
//    return [super forwardingTargetForSelector:aSelector];
//}

//+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
//{
//    if (aSelector == @selector(test)) return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//
//    return [super methodSignatureForSelector:aSelector];
//}
//
//+ (void)forwardInvocation:(NSInvocation *)anInvocation
//{
//    NSLog(@"1123");
//}

@end
