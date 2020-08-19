//
//  KLSignal.m
//  KLTimer
//
//  Created by WKL on 2019/11/12.
//  Copyright © 2019 Ray. All rights reserved.
//

#import "KLSignal.h"

@implementation KLSignal


static KLSignal* _instance = nil;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
        //不是使用alloc方法，而是调用[[super allocWithZone:NULL] init]
        //已经重载allocWithZone基本的对象分配方法，所以要借用父类（NSObject）的功能来帮助出处理底层内存分配的杂物
    }) ;
    return _instance ;
    }

+(id)alloc{
    NSLog(@"alloc");
    return [super alloc];
}
 
 //用alloc返回也是唯一实例
+(id) allocWithZone:(struct _NSZone *)zone {
    
    NSLog(@"allocWithZone");
    return [KLSignal shareInstance] ;
}
//对对象使用copy也是返回唯一实例
-(id)copyWithZone:(NSZone *)zone {
    NSLog(@"copyWithZone");

    return [KLSignal shareInstance] ;//return _instance;
}
 //对对象使用mutablecopy也是返回唯一实例
-(id)mutableCopyWithZone:(NSZone *)zone {
    return [KLSignal shareInstance] ;
}
 
@end
