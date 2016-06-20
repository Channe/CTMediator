//
//  QZMediator+ModuleA_Actions.m
//  QZMediator
//
//  Created by QianLei on 16/6/20.
//  Copyright © 2016年 ichanne. All rights reserved.
//

#import "QZMediator+ModuleA_Actions.h"

NSString * const kQZMediatorTargetA = @"moduleA";

NSString * const kQZMediatorActionNativFetchDetailViewController = @"nativeFetchDetailViewController";
NSString * const kQZMediatorActionNativePresentImage = @"nativePresentImage";
NSString * const kQZMediatorActionNativeNoImage = @"nativeNoImage";
NSString * const kQZMediatorActionShowAlert = @"showAlert";

@implementation QZMediator (ModuleA_Actions)

- (UIViewController *)QZMediator_viewControllerForDetail;
{
    UIViewController *vc = [self performTarget:kQZMediatorTargetA action:kQZMediatorActionNativFetchDetailViewController params:@{@"key":@"value"}];
    
    if (![vc isKindOfClass:[UIViewController class]]) {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
    
    // view controller 交付出去之后，可以由外界选择是push还是present
    return vc;
}

- (void)QZMediator_presentImage:(UIImage *)image;
{
    if (!image) {
        // 这里处理image为nil的场景，如何处理取决于产品
        [self performTarget:kQZMediatorTargetA
                     action:kQZMediatorActionNativeNoImage
                     params:@{@"image":[UIImage imageNamed:@"noImage"]}];
    }
    
    [self performTarget:kQZMediatorTargetA
                 action:kQZMediatorActionNativePresentImage
                 params:@{@"image":image}];
}

@end
