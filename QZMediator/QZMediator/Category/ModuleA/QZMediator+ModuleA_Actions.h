//
//  QZMediator+ModuleA_Actions.h
//  QZMediator
//
//  Created by QianLei on 16/6/20.
//  Copyright © 2016年 ichanne. All rights reserved.
//

#import "QZMediator.h"
#import <UIKit/UIKit.h>

/*
 ModuleA 负责提供这个 CTMediator 分类，公开可供外部模块调用的方法，
 同时将普通参数、复杂参数、非常规参数封装成字典供 CTMediator 主类performTarget:action:params:调用
 这里有 hardcode，在所难免，但是调用者不用关心
 */
@interface QZMediator (ModuleA_Actions)

//普通参数
- (UIViewController *)QZMediator_viewControllerForDetail;
//非常规参数：不可 json 化的参数
- (void)QZMediator_showAlertWithMessage:(NSString *)message cancelAction:(void(^)(NSDictionary *info))cancelAction confirmAction:(void(^)(NSDictionary *info))confirmAction;
- (void)QZMediator_presentImage:(UIImage *)image;

@end
