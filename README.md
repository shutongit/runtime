# runtime
iOS运行时


## OC 的消息机制
- OC中的方法调用其实都是转成了objc_msgSend函数的调用，给receiver（方法调用者）发送了一条消息（selector方法名）
- objc_msgSend底层有3大阶段
    - 消息发送（当前类、父类中查找）、动态方法解析、消息转发
   
   
   
### 消息发送流程

### 动态方法解析

### 消息转发流程
- 调用forwardingTargetForSelector:方法
    - 返回值不为nil： 执行objc_msgSend（返回值，SEL）
    - 返回值为nil：调用methodSignatureForSeletor：方法
        - 返回值不为nil：调用forwordInvocation：方法
        - 返回值为nil：调用doesNotRecognizeSelector：方法
        
>> 开发者可以在forwardInvocation:方法中自定义任何逻辑
以上方法都有对象方法、类方法2个版本（前面可以是加号+，也可以是减号-）


