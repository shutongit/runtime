# runtime
iOS运行时


## 1 OC 的消息机制
- OC中的方法调用其实都是转成了objc_msgSend函数的调用，给receiver（方法调用者）发送了一条消息（selector方法名）
- objc_msgSend底层有3大阶段
    - 消息发送（当前类、父类中查找）、动态方法解析、消息转发
   
   
   
### 1.1 消息发送流程(objc_msgSend(receiver,SEL))
- 判断receiver是否为nil
    - 为nil，直接退出
    - 不为nil， 从receiverClass的cache中查找方法
        - 找到方法，调用方法结束查找
        - 没找到， 从receiverClass的class_rw_t中查找方法
            - 找到方法，**调用方法，结束查找并将方法缓存到receiverClass的cache中**
            - 没找到，从superClass的cache中查找方法 **调用方法，结束查找并将方法缓存到receiverClass的cache中**
                - 没找到，从superClass的class_rw_t中查找方法
                    - 找到方法，**调用方法，结束查找并将方法缓存到receiverClass的cache中**
                    - 没找到，判断上层是否还有superClass
                        - 有，继续从superClass的cache中查找方法开始执行
                        - 没有，动态方法解析
                        
>   receiver通过isa指针找到receiverClass
    receiverClass通过superclass指针找到superClass
>>  如果是从class_rw_t中查找方法
    已经排序的，二分查找
    没有排序的，遍历查找



### 1.2 动态方法解析
- 判断是否曾经有动态解析
    - 是 消息转发
    - 否 调用调用`+resolveInstanceMethod:`或者`+resolveClassMethod:`方法来动态解析方法
        - 标记为已经动态解析
        - 消息发送（会重新“从receiverClass的cache中查找方法”这一步开始执行）

### 1.3 消息转发流程
- 调用`forwardingTargetForSelector:`方法
    - 返回值不为nil： 执行`objc_msgSend（返回值，SEL）`
    - 返回值为nil：调用`methodSignatureForSeletor：`方法
        - 返回值不为nil：调用`forwordInvocation：`方法
        - 返回值为nil：调用`doesNotRecognizeSelector：`方法
        
> 开发者可以在forwardInvocation:方法中自定义任何逻辑
以上方法都有对象方法、类方法2个版本（前面可以是加号+，也可以是减号-）



## 2 runtime在项目中的使用

