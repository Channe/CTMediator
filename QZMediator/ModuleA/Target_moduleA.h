//
//  Target_A.h
//  QZMediator
//
//  Created by QianLei on 16/6/20.
//  Copyright © 2016年 ichanne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 Action从属于Module，所以Action直接可以使用Module里的所有声明，
 Module 一般包含不止一个 UIViewController，所以其不能是分类
 Mediator 每一个方法里都要写 runtime 方法，格式是确定的，这是可以抽取出来的
 target就是class，action就是selector，通过一些规则简化动态调用
 */
@interface Target_moduleA : NSObject

//这些都是供其他模块调用的方法，Mediator 根据方法名来调用，统一添加了 Action_ 前缀，如果一个方法只供内部调用，不提供远程调用，在添加 native 前缀

//使用者获得view controller之后，到底push还是present，由使用者自己决定的，mediator只要给出view controller的实例就好
- (UIViewController *)Action_nativeFetchDetailViewController:(NSDictionary *)params;

//下面两个 Action 其实返回 nil，但是为了统一，必须要有返回值
- (id)Action_nativePresentImage:(NSDictionary *)params;

- (id)Action_showAlert:(NSDictionary *)params;

// 容错
- (id)Action_nativeDefaultImage:(NSDictionary *)params;

@end
