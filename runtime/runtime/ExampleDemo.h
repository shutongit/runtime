//
//  ExampleDemo.h
//  runtime
//
//  Created by 舒通 on 2022/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExampleDemo : NSObject
/// 掩码
- (void)maskDemo01;
/// 位域
- (void)maskDemo02;
/// 共用体
- (void)maskDemo03;
/// 消息发送
- (void)maskDemo04;
/// 动态解析
- (void)maskDemo05;
/// 消息转发
- (void)maskDemo06;
/// class的区分
- (void)classDemo07;
/// super
- (void)superDemo08;
/// 字典转模型
- (void)objectTojson8;
/// 创建类
//- (void)createCustomClass;
void createCustomClass(void);

@end

NS_ASSUME_NONNULL_END
