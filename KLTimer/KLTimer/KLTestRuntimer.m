//
//  KLTestRuntimer.m
//  KLTimer
//
//  Created by WKL on 2020/8/19.
//  Copyright © 2020 Ray. All rights reserved.
//

#import "KLTestRuntimer.h"


#import <objc/runtime.h>


@implementation KLTestRuntimer

-(void)test_other{
    
    NSLog(@"%s",__func__) ;
}

//1 消息发送






#pragma mark - 2. 动态解析 ,动态解析后,会重新走"消息发送"流程
//"从receiverClass的cache中查找方法"这一步开始执行

struct method_t {
    SEL sel ;
    char *types;
    IMP imp ;
} ;
//+(BOOL)resolveInstanceMethod:(SEL)sel{
//
//    if (sel == @selector(pvt_test)) {
//
//        //获取其他方法
//        struct method_t * newMethod =  (struct method_t*)class_getInstanceMethod(self, @selector(test_other)) ;
//        //动态添加方法
//        class_addMethod(self, sel, newMethod->imp, newMethod->types) ;
//        //返回YES代表有动态添加方法
//        return  YES ;
//    }
//
//    return  [super resolveInstanceMethod:sel];
//}

+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    if (sel == @selector(pvt_test)) {
        
        //获取其他方法
        Method newMethod =   class_getInstanceMethod(self, @selector(test_other)) ;
        
        NSLog(@"%s",method_getTypeEncoding(newMethod)) ;
        //动态添加方法
        class_addMethod(self, sel,  method_getImplementation(newMethod), method_getTypeEncoding(newMethod)) ;
        //返回YES代表有动态添加方法
        return  YES ;
    }
    
    return  [super resolveInstanceMethod:sel];
}


void c_other(id self ,SEL _cmd){
    
    NSLog(@"c语言方法 %@  %@",self,NSStringFromSelector(_cmd)) ;
}

//+(BOOL)resolveInstanceMethod:(SEL)sel{
//
//    if (sel == @selector(pvt_test)) {
//
//
//        //动态添加方法,如果有添加就不再执行后续消息转发
//        class_addMethod(self, sel,  (IMP)c_other,  "v@:") ;
//        //返回YES代表有动态添加方法
//        return  YES ;
//    }
//
//    return  [super resolveInstanceMethod:sel];
//}

//类方法 动态解析
+(BOOL)resolveClassMethod:(SEL)sel{
    
    if (sel == @selector(pvt_classtest)) {
        
        //动态添加方法 获取元类对象meta_class
//        class_addMethod(object_getClass(self), sel,  (IMP)c_other,  "v@:") ;
        //返回YES代表有动态添加方法
        return  YES ;
    }
    
    return  [super resolveInstanceMethod:sel];
}


#pragma nark- 3 消息转发 如果消息发送和动态解析中都没有找到方法 ,就会进入消息转发阶段

//返回一个能处理消息的对象,如果返回为nil 执行forwardingTargetForSelector
- (id)forwardingTargetForSelector:(SEL)aSelector{
    
    
    //    objc_mesSend(返回值 ,aSelector) ;
    if (aSelector == @selector(pvt_test)) {
        //        return [KLOtherPerson new] ;
        
        return  nil ;
    }
    
    return [super forwardingTargetForSelector:aSelector] ;
}



//如果 forwardingTargetForSelector 返回的对象为空会调用这个方法获取方法签名
//返回值类型,参数类型
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    if (aSelector == @selector(pvt_test)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"] ;
        
        //         return [[KLOtherPerson new] methodSignatureForSelector:aSelector] ;
        
    }
    return  [NSMethodSignature methodSignatureForSelector:aSelector] ;
}

-(void)forwardInvocation:(NSInvocation *)anInvocation{
    
    
    [anInvocation invokeWithTarget:[KLOtherPerson new]];
}




//类方法调用
+ (id)forwardingTargetForSelector:(SEL)aSelector{
    
    if(aSelector == @selector(pvt_classtest)){
//        return [KLOtherPerson class] ;

        return  nil ;
    }
    
    return [super forwardingTargetForSelector:aSelector] ;
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    if (aSelector == @selector(pvt_classtest)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"] ;
        
        //         return [[KLOtherPerson new] methodSignatureForSelector:aSelector] ;
        
    }
    return  [NSMethodSignature methodSignatureForSelector:aSelector] ;
}

+(void)forwardInvocation:(NSInvocation *)anInvocation{
    
    
    [anInvocation invokeWithTarget:[KLOtherPerson class]];
}




-(void)doesNotRecognizeSelector:(SEL)aSelector {
    
    NSLog(@"%s",__func__) ;
    
}
@end








@implementation KLOtherPerson

-(void)pvt_test;{
    NSLog(@"%s",__func__) ;
    
}
+(void)pvt_classtest{
    NSLog(@"%s",__func__) ;
    
}

@end
