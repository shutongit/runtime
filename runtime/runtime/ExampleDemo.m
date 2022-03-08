//
//  ExampleDemo.m
//  runtime
//
//  Created by 舒通 on 2022/3/8.
//

#import "ExampleDemo.h"
#import "STPerson01.h"
#import "STPerson02.h"
#import "STPerson03.h"
#import "STPerson04.h"
#import "STPerson05.h"
#import "STPerson06.h"
#import "STPerson07.h"
#import "STPerson08.h"
#import "NSObject+Json.h"
#import <objc/runtime.h>


@implementation ExampleDemo


- (void)maskDemo01 {
    STPerson01 *person = [[STPerson01 alloc]init];
    [person setHandsome:YES];
    NSLog(@"tall:%d, rich:%d, handsome:%d",person.isTall, person.isRich, person.isHandsome);
}
- (void)maskDemo02 {
    STPerson02 *person = [[STPerson02 alloc]init];
    [person setHandsome:YES];
    NSLog(@"tall:%d, rich:%d, handsome:%d",person.isTall, person.isRich, person.isHandsome);
}
- (void)maskDemo03 {
    STPerson02 *person = [[STPerson02 alloc]init];
    [person setRich:YES];
    NSLog(@"tall:%d, rich:%d, handsome:%d",person.isTall, person.isRich, person.isHandsome);
}
- (void)maskDemo04 {
    STPerson04 *person = [[STPerson04 alloc]init];
    [person test01];
//    objc_msgSend(person, @selector(test01)); // 消息接收者（receiver）：person， 消息名称：test01
    
    [STPerson04 initialize];
    // objc_msgSend([STPerson04 class], @selector(initialize));
    // 消息接收者（receiver）：[STPerson04 class]
    // 消息名称：initialize
    
    // OC的方法调用：消息机制，给方法调用者发送消息
    
    // objc_msgSend如果找不到合适的方法进行调用，会报错unrecognized selector sent to instance
}

- (void)maskDemo05 {
    [STPerson05 classTest];
    STPerson05 *person = [[STPerson05 alloc]init];
    [person test];
}

- (void)maskDemo06 {
    STPerson06 *person = [[STPerson06 alloc]init];
    [person test];
    [person setAge:18];
}

- (void)classDemo07 {
    STPerson07 *person = [[STPerson07 alloc]init];
    NSLog(@"%d",[[NSObject class] isKindOfClass:[NSObject class]]); //1
    NSLog(@"%d",[[NSObject class] isMemberOfClass:[NSObject class]]);//0
    NSLog(@"%d",[[STPerson07 class] isKindOfClass:[NSObject class]]);//1
    NSLog(@"%d",[[STPerson07 class] isMemberOfClass:[NSObject class]]);//0
    NSLog(@"------");
    NSLog(@"%d",[[person class] isKindOfClass:[NSObject class]]); //1
    NSLog(@"%d",[[person class] isMemberOfClass:[NSObject class]]);//0
    NSLog(@"%d",[[person class] isKindOfClass:[STPerson07 class]]);//0
    NSLog(@"%d",[[person class] isMemberOfClass:[STPerson07 class]]);//0
    
    NSLog(@"------");
    NSLog(@"%d",[NSObject isKindOfClass:[NSObject class]]); // 元类的父类还是NSObject
    NSLog(@"%d",[NSObject isMemberOfClass:[NSObject class]]);
    NSLog(@"%d",[STPerson07 isKindOfClass:[STPerson07 class]]);
    NSLog(@"%d",[STPerson07 isMemberOfClass:[STPerson07 class]]);
}
//- (BOOL)isMemberOfClass:(Class)cls {
//    return [self class] == cls;
//}
//
//- (BOOL)isKindOfClass:(Class)cls {
//    for (Class tcls = [self class]; tcls; tcls = tcls->superclass) {
//        if (tcls == cls) return YES;
//    }
//    return NO;
//}
//
//
//+ (BOOL)isMemberOfClass:(Class)cls {
//    return object_getClass((id)self) == cls;
//}
//
//
//+ (BOOL)isKindOfClass:(Class)cls {
//    for (Class tcls = object_getClass((id)self); tcls; tcls = tcls->superclass) {
//        if (tcls == cls) return YES;
//    }
//    return NO;
//}

- (void)superDemo08 {
//    id cls = [STPerson07 class];
//    void *obj = &cls;
//    [(__bridge id)obj print];
}


- (void)objectTojson8 {
    // 字典转模型
    NSDictionary *json = @{
        @"id" : @20,
        @"age" : @20,
        @"weight" : @60,
        @"name" : @"Jack"
        //                               @"no" : @30
    };
    STPerson08 *person = [STPerson08 st_objectWithJson:json];
    NSLog(@"id:%d,age:%d,weigth:%d,name:%@",person.ID,person.age,person.weight, person.name);
}
void st_allocMethod((id self, SEL _cmd))
{
    NSLog(@"%s",__func__);
}
void createCustomClass () {
    // 创建类
    Class newClass = objc_allocateClassPair([NSObject class], "STDog", 0);
    // 添加属性
    class_addIvar(newClass, "_age", 4, 1, @encode(int));
    class_addIvar(newClass, "_weight", 4, 1, @encode(int));
    // 添加方法
    class_addMethod(newClass, @selector(st_allocMethod), (IMP)st_allocMethod, "v@:");
    // 注册类
    objc_registerClassPair(newClass);
    
    /// 调用
    id dog = [[newClass alloc]init];
    [dog setValue:@10 forKey:@"_age"];
    [dog setValue:@20 forKey:@"_weight"];
//    [dog st_allocMethod];
    NSLog(@"%@ %@", [dog valueForKey:@"_age"], [dog valueForKey:@"_weight"]);
    // 再不需要的地方释放类
    objc_disposeClassPair(newClass);
}


@end
