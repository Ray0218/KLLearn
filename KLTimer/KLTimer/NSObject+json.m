//
//  NSObject+json.m
//  KLTimer
//
//  Created by WKL on 2020/8/20.
//  Copyright © 2020 Ray. All rights reserved.
//

#import "NSObject+json.h"
#import <objc/runtime.h>


@implementation NSObject (json)

+(instancetype)mj_objctWithJson:(NSDictionary*)json{
    
    id obj = [[self alloc]init];
    
    unsigned rCount ;
    
    Ivar *ivars = class_copyIvarList(self, &rCount) ;
    for (int i = 0; i < rCount; i++) {
        Ivar iva = ivars[i] ;
        
        NSMutableString *keyStr = [NSMutableString stringWithUTF8String:ivar_getName(iva)] ;
        [keyStr deleteCharactersInRange:NSMakeRange(0, 1)];
        
        if ([json.allKeys containsObject:keyStr]) {
            [obj setValue:json[keyStr] forKey:keyStr];
        }
    }
    
    free(ivars) ;
    
    return  obj ;
}

@end
