//
//  Target_A.m
//  QZMediator
//
//  Created by QianLei on 16/6/20.
//  Copyright © 2016年 ichanne. All rights reserved.
//

#import "Target_moduleA.h"
//引入这个 Module 下，这个 Action 所有的提供调用接口的 UIViewController
#import "ModuleADetailViewController.h"

typedef void (^QZUrlRouterCallbackBlock)(NSDictionary *info);

@implementation Target_moduleA

//使用者获得view controller之后，到底push还是present，由使用者自己决定的，mediator只要给出view controller的实例就好
- (UIViewController *)Action_nativeFetchDetailViewController:(NSDictionary *)params;
{
    // 因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明
    ModuleADetailViewController *viewController = [[ModuleADetailViewController alloc] init];
    [viewController view];
    viewController.label.text = params[@"key"];
    
    return viewController;
}

- (id)Action_showAlert:(NSDictionary *)params;
{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        QZUrlRouterCallbackBlock callback = params[@"cancelAction"];
        if (callback) {
            callback(@{@"alertAction":action});
        }
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        QZUrlRouterCallbackBlock callback = params[@"confirmAction"];
        if (callback) {
            callback(@{@"alertAction":action});
        }
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"alert from Module A" message:params[@"message"] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];

    return nil;
}

//下面两个 Action 其实返回 nil，但是为了统一，必须要有返回值
- (id)Action_nativePresentImage:(NSDictionary *)params;
{
    ModuleADetailViewController *viewController = [[ModuleADetailViewController alloc] init];
    [viewController view];
    viewController.label.text = @"这是图片";
    viewController.imageView.image = params[@"image"];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:nil];
    
    return nil;
}

// 容错
- (id)Action_nativeDefaultImage:(NSDictionary *)params;
{
    ModuleADetailViewController *viewController = [[ModuleADetailViewController alloc] init];
    [viewController view];
    viewController.label.text = @"默认图片";
    viewController.imageView.image = params[@"image"];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:nil];
    
    return nil;
}

@end
