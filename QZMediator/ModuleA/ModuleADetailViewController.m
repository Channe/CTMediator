//
//  ModuleADetailViewController.m
//  QZMediator
//
//  Created by QianLei on 16/6/20.
//  Copyright © 2016年 ichanne. All rights reserved.
//

#import "ModuleADetailViewController.h"

@interface ModuleADetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *returnButton;
- (IBAction)returnButtonPressed:(UIButton *)sender;

@end

@implementation ModuleADetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)returnButtonPressed:(UIButton *)sender {
    if (!self.navigationController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
