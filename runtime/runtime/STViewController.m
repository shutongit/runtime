//
//  STViewController.m
//  runtime
//
//  Created by 舒通 on 2022/3/8.
//

#import "STViewController.h"
#import "objc/runtime.h"
#import "UITextView+placeHold.h"

@interface STViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) UITextView *textView1;

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
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入内容" attributes:@{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont systemFontOfSize:16]}];
    self.textField.attributedPlaceholder = placeholderString;
    
//    unsigned int index;
//    Ivar *ivars1 = class_copyIvarList([UITextView class], &index);
//    for (int i = 0; i < index; i++) {
//        // 取出i位置的成员变量
//        Ivar ivar = ivars1[i];
//        NSLog(@"--%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
//    }
//    free(ivars1);
    
//    _placeholderLabel
//    UILabel *placeHoldLabel = [self.textView valueForKeyPath:@"_placeholderLabel"];
//    placeHoldLabel.text = @"我是文本输入框";
//    placeHoldLabel.textColor = [UIColor orangeColor];
    
    
//    [self.textView setValue:[UIColor redColor] forKey:@"_placeholderLabel.textColor"];
//    [self setPlaceholder:@"我是文本输入框" placeholdColor:[UIColor orangeColor]];
    
    self.textView.placeHolder = @"我是文本框";
    self.textView.placeHolderColor = [UIColor orangeColor];
    
    
    
    UITextView *view = [[UITextView alloc]initWithFrame:CGRectMake(0, 200, 200, 60)];
    view.placeHolder = @"自ing一";
    
    [self.view addSubview:view];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setPlaceholder:(NSString *)placeholdStr placeholdColor:(UIColor *)placeholdColor
{
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeholdStr;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = placeholdColor;
//    placeHolderLabel.font = self.font;
    [placeHolderLabel sizeToFit];
    
    /*
     [self setValue:(nullable id) forKey:(nonnull NSString *)]
     ps: KVC键值编码，对UITextView的私有属性进行修改
     */
//   if (aviable) {
        UILabel *placeholder = [self valueForKey:@"_placeholderLabel"];
        //防止重复
        if (placeholder) {
            return;
        }
        [self.textView addSubview:placeHolderLabel];
        [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
//    }
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
