//
//  KLPermenThread.h
//  KLTimer
//
//  Created by WKL on 2020/8/22.
//  Copyright © 2020 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLPermenThread : NSObject


/// 开始任务
/// @param task 任务
-(void)kl_begainTask:(void(^)(void))task ;


/// 结束线程
-(void)kl_stopThread;


@end

NS_ASSUME_NONNULL_END
