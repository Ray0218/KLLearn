//
//  UIControl+Action.m
//  KLTimer
//
//  Created by WKL on 2020/8/20.
//  Copyright © 2020 Ray. All rights reserved.
//

#import "UIControl+Action.h"
#import <objc/runtime.h>
 

@implementation UIControl (Action)

+(void)load{
    
    
    Method sysMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:)) ;
    Method cusMethod = class_getInstanceMethod(self, @selector(kl_sendAction:to:forEvent:)) ;

    
    
    method_exchangeImplementations(sysMethod, cusMethod) ;
    
    
}


- (void)kl_sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event{
    
    NSLog(@"#######  有点击   ######") ;
    
    [self kl_sendAction:action to:target forEvent:event];
}


@end
