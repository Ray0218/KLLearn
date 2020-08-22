//
//  TimeViewController.m
//  KLTimer
//
//  Created by WKL on 2019/11/12.
//  Copyright © 2019 Ray. All rights reserved.
//

#import "TimeViewController.h"

#import "NSTimer+Extern.h"

@interface TimeViewController (){
    
    NSTimer *_rTimer ;
}

@end

@implementation TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.se
    self.title = @"测试" ;
    
    
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random()%50+50)/255.0  green:(arc4random()%105/255.0 + 40)/255.0  blue:(arc4random()%105+ 150)/255.0  alpha:1];
    
//    [self gcdTimer:1 repeats:YES];
    
    [self startTimeCustBlock];
    //    [self startTimerBlock];
     
    
    //        [self startTimeFirst];
    
    //    [self starttimeTwo];
    
    
    //    [NSThread detachNewThreadSelector:@selector(dateChecking) toTarget:self withObject:nil];
    
    
}

-(void)gcdTimer:(NSTimeInterval)timeinterval repeats:(BOOL)repeat {
    
    //内存问题 前提:event_handler里面没有包含timerTwo时,当timerTwo为成员变量是,没问题,当为局部变量时,只运行一次,但是只要里面有timerTwo,就没问题
    __weak typeof(self) weakSelf = self;

    dispatch_queue_t queue = dispatch_queue_create("Ray", 0);
    
    dispatch_source_t timerTwo = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timerTwo, DISPATCH_TIME_NOW, timeinterval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timerTwo, ^{
        
 //         if (!repeat) {
//            dispatch_cancel(timer);
//        }else{
//            [weakSelf rSelector];
//            [self rSelector];

//        }
        timerTwo;
        
        __strong typeof(self) strongSelf = weakSelf;
               [strongSelf rSelector ];
        
        NSLog(@"退出event_handler");
         
    });
    dispatch_resume(timerTwo);
    
}

-(void)dateChecking{
    
    _rTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(rSelector) userInfo:nil repeats:YES] ;
    [[NSRunLoop currentRunLoop]addTimer:_rTimer forMode:NSRunLoopCommonModes];
    
    //子线程的timer要取消掉必须在当前子线程中取消,不要在主线程,不然会造成runloop浪费
    [self performSelector:@selector(invalidateTimer) withObject:nil afterDelay:3];
    
    //    NSRunLoop 在子线程下是不会自动调用的,需要手动调用
    [[NSRunLoop currentRunLoop]run];
    
    
    NSLog(@"##### 子线程结束了######");
    
}

-(void)invalidateTimer{
    
    [_rTimer invalidate];
    _rTimer = nil;
}


-(void)startTimeCustBlock{
    
    __weak typeof(self) weakSelf = self;
    
    _rTimer = [NSTimer rtimerWithTimeInterval:1 repeats:YES block:^{
        
        
        __strong typeof(self) strongSelf = weakSelf;

        [strongSelf rSelector ];
        
        NSLog(@"startTimerBlock");

    }];
    
    [[NSRunLoop currentRunLoop]addTimer:_rTimer forMode:NSRunLoopCommonModes];
    
}

-(void)startTimerBlock{
    __weak typeof(self) weakSelf = self;
    _rTimer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf rSelector ];
        
        NSLog(@" startTimerBlock");

        
    }];
    
    [[NSRunLoop currentRunLoop]addTimer:_rTimer forMode:NSRunLoopCommonModes];
    
}
-(void)startTimeFirst{
    
    //    dealloc 不会被调用
    //    self -> timer -> self    timer的销毁依赖于dealloc方法里的invalidate ,而self的销毁依赖于timer的销毁
    //runloop对timer 有了强引用, weak型的timer不会被释放
    _rTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(rSelector) userInfo:nil repeats:YES];
    
}

-(void)starttimeTwo {
    
    _rTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(rSelector) userInfo:nil repeats:YES] ;
    [[NSRunLoop currentRunLoop]addTimer:_rTimer forMode:NSRunLoopCommonModes];
    
    
    //    fire 只是实时触发定时器,调用定时器方法,而且不影响定时器的周期
    //    [_rTimer fire];
 
}

-(void)rSelector {
    
    NSLog(@"Tiemer...");
}


-(void)dealloc{
    [_rTimer invalidate];
    _rTimer = nil ;
    NSLog(@"########### 被释放了############") ;
}
@end
