//
//  QZMediator.m
//  QZMediator
//
//  Created by QianLei on 16/6/20.
//  Copyright © 2016年 ichanne. All rights reserved.
//

#import "QZMediator.h"

@implementation QZMediator

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static QZMediator *mediator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[QZMediator alloc] init];
    });
    return mediator;
}

/*
 scheme://[target]/[action]?[params]
 
 url sample:
 aaa://targetA/actionB?id=1234
 */
// 远程App调用入口
- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;
{
#warning todo 修改aaa为你自己app的scheme
    if (![url.scheme isEqualToString:@"aaa"]) {
        // 这里就是针对远程app调用404的简单处理了，根据不同app的产品经理要求不同，你们可以在这里自己做需要的逻辑
        return @(NO);
    }
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    NSString *urlString = url.query;
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elements = [param componentsSeparatedByString:@"="];
        if (elements.count < 2) continue;
        params[elements.firstObject] = elements.lastObject;
    }
    
    // 这里这么写主要是出于安全考虑，防止黑客通过远程方式调用本地模块。这里的做法足以应对绝大多数场景，如果要求更加严苛，也可以做更加复杂的安全逻辑。
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([actionName hasPrefix:@"native"]) {
        return @(NO);
    }
    
    //调用本地组件调用入口
    // 这个demo针对URL的路由处理非常简单，就只是取对应的target名字和method名字，但这已经足以应对绝大部份需求。如果需要拓展，可以在这个方法调用之前加入完整的路由逻辑
    id result = [self performTarget:url.host action:actionName params:params];
    if (result) {
        BLOCK_EXEC(completion,@{@"result":result});
    } else {
        BLOCK_EXEC(completion,nil);
    }
    
    return result;
}

// 本地组件调用入口
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;
{
    NSString *targetClassString = [@"Target_" stringByAppendingString:targetName];
    NSString *actionString = [NSString stringWithFormat:@"Action_%@:", actionName];
    
    Class targetClass = NSClassFromString(targetClassString);
    id target = [[targetClass alloc] init];//class of Target_A
    SEL action = NSSelectorFromString(actionString);
    
    if (!target) {
        // 这里是处理无响应请求的地方之一，这个demo做得比较简单，如果没有可以响应的target，就直接return了。实际开发过程中是可以事先给一个固定的target专门用于在这个时候顶上，然后处理这种请求的
        return nil;
    }
    
    // 这里是处理无响应请求的地方，如果无响应，则尝试调用对应target的notFound方法统一处理
    if (![target respondsToSelector:action]) {
        SEL action = NSSelectorFromString(@"notFound:");
        if (![target respondsToSelector:action]) {
            // 这里也是处理无响应请求的地方，在notFound都没有的时候，这个demo是直接return了。实际开发过程中，可以用前面提到的固定的target顶上的。
            return nil;
        }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    
}

@end
