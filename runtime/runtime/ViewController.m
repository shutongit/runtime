//
//  ViewController.m
//  runtime
//
//  Created by 舒通 on 2022/3/8.
//

#import "ViewController.h"
#import "ExampleDemo.h"
#import "STPerson07.h"
#import "STViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
static NSString *key1 = @"name", *key2 = @"description", *key3 = @"index", *title= @"title", *content=@"content";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // super
    id cls = [STPerson07 class];
    void *obj = &cls;
    [(__bridge id)obj print];
    
    [self setup];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    NSDictionary *dic = self.dataArray[indexPath.section];
    NSArray *list = dic[content];
    NSDictionary *param = list[indexPath.row];
    cell.textLabel.text = param[key1];
    cell.detailTextLabel.text = param[key2];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = self.dataArray[section];
    NSArray *list = dic[content];
    return  list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  50.f;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *dic = self.dataArray[section];
    NSString *str = dic[title];
    return str;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ExampleDemo *demo = [[ExampleDemo alloc]init];
    NSDictionary *dic = self.dataArray[indexPath.section];
    NSArray *list = dic[content];
    NSDictionary *param = list[indexPath.row];
    switch ([param[key3] intValue]) {
        case 0:
        {
            
            [demo maskDemo01];
        }
            break;
        case 1:
        {
            [demo maskDemo02];
        }
            break;
        case 2:
        {
            [demo maskDemo03];
        }
            break;
        case 3:
        {
            [demo maskDemo04];
        }
            break;
        case 4:
        {
            [demo maskDemo05];
        }
            break;
        case 5:
        {
            [demo maskDemo06];
        }
            break;
        case 6:
        {
            [demo classDemo07];
        }
            break;
        case 7:
        {
        }
            break;
        case 8:
        {
            [demo objectTojson8];
        }
            break;
        case 9:
        {
            createCustomClass();
        }
            break;
        case 10:
        {
            STViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"STViewController"];
            vc.modalPresentationStyle = UIModalPresentationCurrentContext;
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
    
}
- (void)setup {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.dataArray addObjectsFromArray:@[
        @{title:@"runtime基础", content:@[
            @{key1:@"掩码  按位与或",key2:@"掩码，一般用来按位与(&)运算的",key3:@0},
            @{key1:@"位域",key2:@"",key3:@1},
            @{key1:@"共用体",key2:@"union",key3:@2},]},
        
        @{title:@"objc_msgSend执行流程", content: @[
            @{key1:@"消息发送",key2:@"objc_msgSend(接收者、名称)",key3:@3},
            @{key1:@"动态解析",key2:@"resolveInstanceMethod/resolveClassMethod",key3:@4},
            @{key1:@"消息转发",key2:@"forwardingTargetForSelector:/ methodSignatureForSelector:/forwardInvocation:",key3:@5},
        ]},
        @{title:@"super / class", content: @[
            @{key1:@"class",key2:@"",key3:@6},
            @{key1:@"super",key2:@"",key3:@7},
        ]},
        @{title:@"runtime的应用", content: @[
            @{key1:@"数据转model",key2:@"",key3:@8},
            @{key1:@"使用runtime创建类",key2:@"",key3:@9},
            @{key1:@"修改textFiled的placeHold样式",key2:@"",key3:@10},
        ]},
        
    ]];
    [self.tableView reloadData];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
