//
//  KLTimer.m
//  KLTimer
//
//  Created by WKL on 2020/8/24.
//  Copyright © 2020 Ray. All rights reserved.
//

#import "KLTimer.h"

@interface KLTimer ()

@property(nonatomic,strong)dispatch_source_t rTimer;

@end

@implementation KLTimer

static NSMutableDictionary *timers_;

static  dispatch_semaphore_t semaphore_ ;

+(void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary dictionary] ;
        semaphore_ = dispatch_semaphore_create(1) ;
    });
    
    
    
}
+(void)kl_execTask:(void(^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async{
    
    
    if (!task || start < 0 || (interval <= 0 && repeats)) {
        return ;
    }
    
    
    
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue() ;
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, start * NSEC_PER_SEC, interval * NSEC_PER_SEC);
    
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER) ;
    
    NSString *name = [NSString stringWithFormat:@"%zd",timers_.count] ;
    timers_[name] = timer ;
    dispatch_semaphore_signal(semaphore_) ;
    
    
    dispatch_source_set_event_handler(timer, ^{
        task() ;
        if (!repeats) {
            
            [self kl_cancelTask:name];
        }
    });
    dispatch_resume(timer);
    
    
}

+(void)kl_cancelTask:(NSString*)name{
    
    if (name.length == 0) {
        return ;
    }
    
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER) ;
    dispatch_source_t timer = timers_[name] ;
    
    if (timer) {
        
        dispatch_source_cancel(timers_[name]) ;
        
        [timers_ removeObjectForKey:name];
    }
    
    dispatch_semaphore_signal(semaphore_) ;
    
    
}
- (void)dealloc
{
    NSLog(@"%s",__func__) ;
}

@end
