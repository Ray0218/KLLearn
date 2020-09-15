//
//  KLTimer.h
//  KLTimer
//
//  Created by WKL on 2020/8/24.
//  Copyright © 2020 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLTimer : NSObject

+(void)kl_execTask:(void(^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async ;

+(void)kl_cancelTask:(NSString*)name ;

@end

NS_ASSUME_NONNULL_END
