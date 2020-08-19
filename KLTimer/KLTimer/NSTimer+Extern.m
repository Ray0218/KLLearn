//
//  NSTimer+Extern.m
//  KLTimer
//
//  Created by WKL on 2019/11/12.
//  Copyright © 2019 Ray. All rights reserved.
//

#import "NSTimer+Extern.h"

 

@implementation NSTimer (Extern)

//block在arc下,一般情况下是自动copy的
//作为自己参数的函数.block 它是不copy的,系统的一些哪怕是函数的参数他也不会copy

+ (NSTimer *)rtimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(void))block{

    return [NSTimer timerWithTimeInterval:interval target:self selector:@selector(timeAction:) userInfo:block repeats:repeats];
}

+(void)timeAction:(NSTimer *)timer{
    
    void(^ block)(void) = timer.userInfo ;
    
 
    if (block) {
        block();
    }
    
//    NSLog(@"*** %s",object_getClassName(block));

    
}

@end
