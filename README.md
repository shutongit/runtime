# runtime
iOS运行时

## Class的结构
### 基础结构
```
    struct objc_class {
        Class isa;
        Class superclass;
        cache_t cache; //方法缓存
        class_data_bits_t bits; //用户获取具体的类信息 换位与掩码 (& FAST_DATA_MASK)之后获取
    }

```
###  `class_data_bits_t` & FAST_DATA_MASK 获取到 `class_rw_t`的结构
```
    struct class_rw_t {
        uint32_t flags;
        uint32_t version;
        const class_ro_t *ro;
        method_list_t * methods;    // 方法列表
        property_list_t *properties;    // 属性列表
        const protocol_list_t * protocols;  // 协议列表
        Class firstSubclass;
        Class nextSiblingClass;
        char *demangledName;
    };
```
 ### `const class_ro_t *ro;`的结构
 ```
     struct class_ro_t {
        uint32_t flags;
        uint32_t instanceStart;
        uint32_t instanceSize;  // instance对象占用的内存空间
    #ifdef __LP64__
        uint32_t reserved;
    #endif
        const uint8_t * ivarLayout;
        const char * name;  // 类名
        method_list_t * baseMethodList;
        protocol_list_t * baseProtocols;
        const ivar_list_t * ivars;  // 成员变量列表
        const uint8_t * weakIvarLayout;
        property_list_t *baseProperties;
    };
 
 ```
 
 

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
                        
  > - receiver通过isa指针找到receiverClass
    receiverClass通过superclass指针找到superClass
  > - 如果是从class_rw_t中查找方法
    >>- 已经排序的，二分查找
    >>- 没有排序的，遍历查找



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
        
    > - 开发者可以在forwardInvocation:方法中自定义任何逻辑
    > - 以上方法都有对象方法、类方法2个版本（前面可以是加号+，也可以是减号-）



## 2 什么是Runtime？runtime在项目中的使用
### 2.1 什么是runtime
  - OC是一门动态性比较强的编程语言，允许很多操作推迟到程序运行时再进行
  - OC的动态性就是由Runtime来支撑和实现的，Runtime是一套C语言的API，封装了很多动态性相关的函数
  - 平时编写的OC代码，底层都是转成了Runtime API进行调用
### 2.2 使用
  - 利用关联对象(AssociatedObject)给分类添加属性
  - 遍历类的所有成员变量(修改textFiled的占位文字颜色、字典转模型、自动归档解档)
  - 交换方法实现(交换系统的方法)
  - 利用消息转发机制解决方法找不到的异常问题
  ...

