//
//  TableViewController.m
//  QZMediator
//
//  Created by QianLei on 16/6/20.
//  Copyright © 2016年 ichanne. All rights reserved.
//

#import "TableViewController.h"
//导入模块相应的 Mediator Actions
//调用者依赖于中介者，但与被调用者隔离；被调用者不依赖于中介者，避免相互依赖
//各组件互不依赖，组件间调用只依赖中间件Mediator，Mediator不依赖其他组件。
#import "QZMediator+ModuleA_Actions.h"

@interface TableViewController ()

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"present detail view controller",
                       @"push detail view controller",
                       @"present image",
                       @"present image when error",
                       @"show alert"];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kCellIdentifier"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        // 获得view controller之后，到底push还是present，由使用者决定的，mediator只要给出view controller的实例就好了
        UIViewController *viewController = [[QZMediator sharedInstance] QZMediator_viewControllerForDetail];
        // present
        [self presentViewController:viewController animated:YES completion:nil];
    }
    
    if (indexPath.row == 1) {
        UIViewController *viewController = [[QZMediator sharedInstance] QZMediator_viewControllerForDetail];
        // push
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    if (indexPath.row == 2) {
        // 场景：很明显是需要被present的，不必返回实例，mediator直接present了
        [[QZMediator sharedInstance] QZMediator_presentImage:[UIImage imageNamed:@"image"]];
    }
    
    if (indexPath.row == 3) {
        // 场景：参数有问题，因此需要在流程中做好处理
        [[QZMediator sharedInstance] QZMediator_presentImage:nil];
    }
    
    if (indexPath.row == 4) {
        // 场景：参数为 block 
        [[QZMediator sharedInstance] QZMediator_showAlertWithMessage:@"弹窗消息" cancelAction:nil confirmAction:^(NSDictionary *info) {
            // 做你想做的事
            NSLog(@"%@", info);
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
