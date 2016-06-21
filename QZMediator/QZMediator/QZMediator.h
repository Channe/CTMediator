//
//  QZMediator.h
//  QZMediator
//
//  Created by QianLei on 16/6/20.
//  Copyright © 2016年 ichanne. All rights reserved.
//


/*
 组件通过中间件 Mediator 通信，中间件通过 runtime 接口解耦，
 通过 target-action 简化写法，通过 category 感官上分离组件接口代码。
 */
#import <Foundation/Foundation.h>

///block 安全调用
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

/*
 基于Mediator模式和Target-Action模式，中间采用了runtime来完成调用
 */

@interface QZMediator : NSObject

+ (instancetype)sharedInstance;

// 远程App调用入口
- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;
// 本地组件调用入口
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;

@end
