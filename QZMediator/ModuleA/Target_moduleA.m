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

@implementation Target_A

//使用者获得view controller之后，到底push还是present，由使用者自己决定的，mediator只要给出view controller的实例就好
- (UIViewController *)Action_nativeFetchDetailViewController:(NSDictionary *)params;
{
    return nil;
}

//下面两个 Action 其实返回 nil，但是为了统一，必须要有返回值
- (id)Action_nativePresentImage:(NSDictionary *)params;
{
    return nil;
}

- (id)Action_showAlert:(NSDictionary *)params;
{
    return nil;
}

// 容错
- (id)Action_nativeNoImage:(NSDictionary *)params;
{
    return nil;
}

@end
