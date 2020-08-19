//
//  NSTimer+Extern.h
//  KLTimer
//
//  Created by WKL on 2019/11/12.
//  Copyright © 2019 Ray. All rights reserved.
//

 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (Extern)

+ (NSTimer *)rtimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(void))block;


@end

NS_ASSUME_NONNULL_END
