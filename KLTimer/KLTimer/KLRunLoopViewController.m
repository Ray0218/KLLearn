//
//  KLRunLoopViewController.m
//  KLTimer
//
//  Created by WKL on 2020/8/21.
//  Copyright © 2020 Ray. All rights reserved.
//

#import "KLRunLoopViewController.h"
#import "KLPermenThread.h"


@interface KLRunLoopViewController ()

@property(nonatomic,strong)KLPermenThread *rThread;

 


@end

@implementation KLRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self test_uesBlock];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"停止线程" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor] ;
    btn.frame = CGRectMake(50, 100, 150, 50) ;
    [btn addTarget:self action:@selector(pvt_click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)pvt_click{
    
    
    [self.rThread kl_stopThread];
}

-(void)test_uesBlock {
    
     self.rThread =  [[KLPermenThread alloc]init];
    
   
}

 
void callout(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
//    CFRunLoopObserverRef observer =  CFRunLoopObserverCreate(CFAllocatorGetDefault(),  kCFRunLoopAllActivities, YES, 0, callout, NULL);
//
//
//       //添加监听
//       CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes) ;
//       CFRelease(observer) ;
//
    
    
 
    
    
    if (!self.rThread) {
        return ;
    }


    [self.rThread kl_begainTask:^{

         NSLog(@"%s --- %@",__func__,[NSThread currentThread]) ;
        
       
    }] ;
}

 
 
-(void)dealloc{
    
    NSLog(@" ### %s ###", __func__) ;
    
 
 
}

@end
