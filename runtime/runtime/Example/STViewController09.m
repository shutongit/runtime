//
//  STViewController09.m
//  runtime
//
//  Created by 舒通 on 2022/3/9.
//

#import "STViewController09.h"
#import "UIControl+Category.h"
#import "NSMutableDictionary+Category.h"

@interface STViewController09 ()

@end

@implementation STViewController09

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createBtn];
    [self setupDic];
    
}


- (void)setupDic {
    // 如果字典添加了nil 会崩溃 使用method_exchange 方法替换执行自己的操作，防止错误
    NSString *obj;
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    NSLog(@"%@",[dic2 class]);
    [dic2 setValue:@"st" forKey:@"name"];
    [dic2 setValue:@18 forKey:@"age"];
    [dic2 setValue:@"111" forKey:obj];
}

- (void)createBtn {
    NSArray *events = @[@"click1",@"click2",@"click3",@"back"];
    for (int i = 0; i < events.count; i ++) {
        NSString *event = events[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:event forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor orangeColor];
        btn.frame = CGRectMake(50, 50+60*i, 100, 50);
        if (i == events.count - 1) {
            btn.frame = CGRectMake(50, 50+60*i, 200, 100);
            btn.backgroundColor = [UIColor grayColor];
        }
        [btn addTarget:self action:NSSelectorFromString(event) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
- (void)click1 {
    NSLog(@"%s",__func__);
}
- (void)click2 {
    NSLog(@"%s",__func__);
}
- (void)click3 {
    NSLog(@"%s",__func__);
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
