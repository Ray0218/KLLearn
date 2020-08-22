//
//  NSMutableArray+SafeAdd.m
//  KLTimer
//
//  Created by WKL on 2020/8/20.
//  Copyright © 2020 Ray. All rights reserved.
//

#import "NSMutableArray+SafeAdd.h"
#import <objc/runtime.h>


@implementation NSMutableArray (SafeAdd)



+(void)initialize{
    
    //类簇: NSString ,NSArray,NSDictionary,真实类型是其他类型
    
    Class cls = NSClassFromString(@"__NSArrayM") ;
    Method sysMethod = class_getInstanceMethod(cls, @selector(insertObject:atIndex:)) ;
    Method cusMethod = class_getInstanceMethod(cls, @selector(kl_insertObject:atIndex:)) ;
    
    
    method_exchangeImplementations(sysMethod, cusMethod) ;
    
    
}

- (void)kl_insertObject:(id)anObject atIndex:(NSUInteger)index{
    
    if(anObject == nil)
        return ;
    
    [self kl_insertObject:anObject atIndex:index];
    
    
}

@end





@implementation NSDictionary (safte)


+(void)initialize{
    
    //类簇: NSString ,NSArray,NSDictionary,真实类型是其他类型
    
    Class cls = NSClassFromString(@"__NSDictionaryI") ;
    Method sysMethod = class_getInstanceMethod(cls, @selector(objectForKeyedSubscript:)) ;
    Method cusMethod = class_getInstanceMethod(cls, @selector(kl_objectForKeyedSubscript:)) ;
    
    
    method_exchangeImplementations(sysMethod, cusMethod) ;
    
}


-(id)kl_objectForKeyedSubscript:(id)key{
    
    if (!key ) {
        return nil ;
    }
    return [self kl_objectForKeyedSubscript:key];
    
    
}
@end




@implementation NSMutableDictionary  (safte)


+(void)initialize{
    
    //类簇: NSString ,NSArray,NSDictionary,真实类型是其他类型
    
    Class cls = NSClassFromString(@"__NSDictionaryM") ;
    Method sysMethod = class_getInstanceMethod(cls, @selector(setObject:forKeyedSubscript:)) ;
    Method cusMethod = class_getInstanceMethod(cls, @selector(kl_setObject:forKeyedSubscript:)) ;
    
    
    method_exchangeImplementations(sysMethod, cusMethod) ;
    
    
}


- (void)kl_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    
    if (!obj || !key) {
        return ;
    }
    
    [self kl_setObject:obj forKeyedSubscript:key];
}


@end

