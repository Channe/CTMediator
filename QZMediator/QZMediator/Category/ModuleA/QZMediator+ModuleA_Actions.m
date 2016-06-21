//
//  QZMediator+ModuleA_Actions.m
//  QZMediator
//
//  Created by QianLei on 16/6/20.
//  Copyright © 2016年 ichanne. All rights reserved.
//

#import "QZMediator+ModuleA_Actions.h"

// 这里的 hardcode 无法避免
// 这里的参数都是和Target-Action中约定好的，好在这两部分代码都是模块提供者编写

NSString * const kTargetA = @"moduleA";

NSString * const kActionNativFetchDetailViewController = @"nativeFetchDetailViewController";
NSString * const kActionNativePresentImage = @"nativePresentImage";
NSString * const kActionnativeDefaultImage = @"nativeDefaultImage";
NSString * const kActionShowAlert = @"showAlert";

@implementation QZMediator (ModuleA_Actions)

- (UIViewController *)QZMediator_viewControllerForDetail;
{
    UIViewController *vc = [self performTarget:kTargetA action:kActionNativFetchDetailViewController params:@{@"key":@"默认value"}];
    
    if (![vc isKindOfClass:[UIViewController class]]) {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
    
    // view controller 交付出去之后，可以由外界选择是push还是present
    return vc;
}

- (void)QZMediator_showAlertWithMessage:(NSString *)message cancelAction:(void(^)(NSDictionary *info))cancelAction confirmAction:(void(^)(NSDictionary *info))confirmAction;
{
    NSMutableDictionary *paramsToSend = [NSMutableDictionary new];
    if (message) {
        paramsToSend[@"message"] = message;
    }
    if (cancelAction) {
        paramsToSend[@"cancelAction"] = cancelAction;
    }
    if (confirmAction) {
        paramsToSend[@"confirmAction"] = confirmAction;
    }
    
    [self performTarget:kTargetA action:kActionShowAlert params:paramsToSend];
}

- (void)QZMediator_presentImage:(UIImage *)image;
{
    if (!image) {
        // 这里处理image为nil的场景，如何处理取决于产品
        [self performTarget:kTargetA
                     action:kActionnativeDefaultImage
                     params:@{@"image":[UIImage imageNamed:@"defaultImage"]}];
        return;
    }
    
    [self performTarget:kTargetA
                 action:kActionNativePresentImage
                 params:@{@"image":image}];
}

@end
