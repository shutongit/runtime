//
//  STViewController.m
//  runtime
//
//  Created by 舒通 on 2022/3/8.
//

#import "STViewController.h"
#import "objc/runtime.h"

@interface STViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation STViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
//    unsigned int count;
//    Ivar *ivars = class_copyIvarList([self.textField class], &count);
//    for (int i = 0; i < count; i++) {
//        // 取出i位置的成员变量
//        Ivar ivar = ivars[i];
//        NSLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
//    }
//    free(ivars);
//    [self.textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    
//    unsigned int index;
//    Ivar *ivars1 = class_copyIvarList([UITextView class], &index);
//    for (int i = 0; i < index; i++) {
//        // 取出i位置的成员变量
//        Ivar ivar = ivars1[i];
//        NSLog(@"--%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
//    }
//    free(ivars1);
    
//    _placeholderLabel
    UILabel *placeHoldLabel = [self.textView valueForKeyPath:@"_placeholderLabel"];
    placeHoldLabel.text = @"我是文本输入框";
    placeHoldLabel.textColor = [UIColor orangeColor];
//    [self.textView setValue:[UIColor redColor] forKey:@"_placeholderLabel.textColor"];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
