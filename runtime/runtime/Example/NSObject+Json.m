//
//  NSObject+Json.m
//  runtime
//
//  Created by 舒通 on 2022/3/8.
//

#import "NSObject+Json.h"
#import <objc/runtime.h>

@implementation NSObject (Json)
+ (instancetype)st_objectWithJson:(NSDictionary *)json {
    id obj = [[self alloc]init];
    // 获取成员列表
    unsigned int count;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i]; // 取出成员
        NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)]; //获取到的name都是以_开头
        [name deleteCharactersInRange:NSMakeRange(0, 1)];
        // 设值
        id value = json[name];
        if ([name isEqualToString:@"ID"]) { // 这里需要其他处理 不能写死
            value = json[@"id"];
        }
        [obj setValue:value forKey:name];
    }
    free(ivars); // 释放
    return obj;
}
@end
