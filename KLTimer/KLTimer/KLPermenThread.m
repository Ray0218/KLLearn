//
//  KLPermenThread.m
//  KLTimer
//
//  Created by WKL on 2020/8/22.
//  Copyright © 2020 Ray. All rights reserved.
//

#import "KLPermenThread.h"

@interface KLThread : NSThread

@end
@implementation KLThread

-(void)dealloc{
    
    NSLog(@"############## %s  #########",__func__) ;
}
@end

@interface  KLPermenThread ()

@property(nonatomic,strong)KLThread *rThread;

@property(nonatomic,assign)BOOL rStop;
@end

@implementation KLPermenThread


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //        _rStop = NO ;
        //        __weak typeof(self) weakSelf = self ;
        //        _rThread = [[KLThread alloc]initWithBlock:^{
        //
        //            NSLog(@" 启动当前线程 ------  %@ ", [NSThread currentThread]) ;
        //            //往RunLoop里添加Source/Timer/Observer,防止RunLoop退出,进而达到线程保活目的
        //            [[NSRunLoop currentRunLoop]addPort:[NSPort new] forMode:NSDefaultRunLoopMode];
        //
        //            [weakSelf addThreadObserve];
        //
        //            while (!weakSelf.rStop && weakSelf) {
        //
        //                [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        //
        //            }
        //
        //            NSLog(@"%s ---线程结束 end ----", __func__) ;
        //
        //        }] ;
        
        
//        typeof (self) weakSel;
// KLPermenThread *self;

        
//        __unsafe_unretained typeof(self) weakSel  = self ;
        //C语言写法
        self.rThread = [[KLThread alloc]initWithBlock:^{
            
            NSLog(@" 启动当前线程 ------  %@ ", [NSThread currentThread]) ;
            
            //创建上下文
            CFRunLoopSourceContext context = {0} ;
            //创建source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context) ;
            //往RunLoop里添加Source/Timer/Observer,防止RunLoop退出,进而达到线程保活目的
            
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode) ;
            //销毁source
            CFRelease(source);
            
            [self addThreadObserve];
            
            
            //false代表执行完source后不退出当前Loop
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false) ;
            
            
            
            NSLog(@"%s ---线程结束 end ----", __func__) ;
            
        }] ;
        
        
        [_rThread start] ;
        
    }
    return self;
}

void callouts(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    
    //    NSLog(@"%@",info) ;
    
    switch (activity) {
            
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry") ;
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers") ;
            break;
            
        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources") ;
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopBeforeWaiting") ;
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"kCFRunLoopAfterWaiting") ;
            break;
        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit") ;
            break;
        case kCFRunLoopAllActivities:
            NSLog(@"kCFRunLoopAllActivities") ;
            break;
            
        default:
            break;
    }
    
    
}

//监听当前线程状态
-(void) addThreadObserve {
    
    CFRunLoopObserverRef observer =  CFRunLoopObserverCreate(CFAllocatorGetDefault(),  kCFRunLoopAllActivities, YES, 0, callouts, NULL);
    
    //添加监听
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes) ;
    CFRelease(observer) ;
    
}

-(void)kl_begainTask:(void (^)(void))task{
    if (!self.rThread || !task) {
        return ;
    }
    
    [self performSelector:@selector(__executeTask:) onThread:self.rThread withObject:task waitUntilDone:NO] ;
    
}

-(void)__executeTask:(void(^)(void)) task{
    
    if (!self.rThread || !task) {
        return ;
    }
    task() ;
    
}

-(void)kl_stopThread{
    
    if (!self.rThread) {
        return ;
    }
    //切换到子线程 waitUntilDone必须等到SEL执行完成
    
    [self performSelector:@selector(__stop) onThread:self.rThread withObject:nil waitUntilDone:YES];
    
}

-(void)__stop{
    
    self.rStop = YES ;
    CFRunLoopStop(CFRunLoopGetCurrent()) ;
    self.rThread = nil ;
}

-(void)dealloc{
    [self kl_stopThread];
    
    NSLog(@"%s",__func__) ;
}


@end
