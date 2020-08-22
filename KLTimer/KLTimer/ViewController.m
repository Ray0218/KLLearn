//
//  ViewController.m
//  KLTimer
//
//  Created by WKL on 2019/11/12.
//  Copyright © 2019 Ray. All rights reserved.
//

#import "ViewController.h"

#import "KLSignal.h"


#import "TimeViewController.h"
#import "KLFloatView.h"
#import <AFNetworking.h>
#import "KLTestRuntimer.h"

#import "KLRunLoopViewController.h"

#import "KLPermenThread.h"



@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"dd";
    NSLog(@"######################################");
  KLSignal *sig =  [KLSignal shareInstance] ;
    self.view.backgroundColor = [UIColor colorWithRed:57.0/255 green:157.0/255 blue:179.0/255 alpha:1];
    
    
    
    NSLog(@"%@",sig) ;
    
    
    KLSignal *ss = [[KLSignal alloc]init];
    
    NSLog(@"%@,%@,%@",ss,[ss copy],[ss mutableCopy]) ;
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor orangeColor] ;
    btn.frame = CGRectMake(50, 100, 150, 50) ;
    [btn addTarget:self action:@selector(pvt_click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"runtime" forState:UIControlStateNormal];
       btn2.backgroundColor = [UIColor orangeColor] ;
       btn2.frame = CGRectMake(50, 200, 150, 50) ;
       [btn2 addTarget:self action:@selector(pvt_clickruntime) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:btn2];
       
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
      [btn3 setTitle:@"RunLoop" forState:UIControlStateNormal];
         btn3.backgroundColor = [UIColor orangeColor] ;
         btn3.frame = CGRectMake(50, 260, 150, 50) ;
         [btn3 addTarget:self action:@selector(pvt_runLoop) forControlEvents:UIControlEventTouchUpInside];
         [self.view addSubview:btn3];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary] ;
    [dict setValue:@"dd" forKey:@"key1"];
    [dict setValue:@"cc" forKey:@"key2"];
    
   NSString *rer =  AFQueryStringFromParameters(dict) ;
    
    
 
    NSLog(@"%@",rer);
    
    
}

-(void)pvt_runLoop{
    
    KLRunLoopViewController *vc = [KLRunLoopViewController new] ;
    [self.navigationController pushViewController:vc animated:YES] ;
    
    
}

-(void)pvt_clickruntime{
    
//    NSObject *dd = [NSObject new];
//    NSString *tesddt = @"123" ;
//
//    id cls = [KLTestRuntimer class] ;
//    void *obj = &cls ;
//    [(__bridge id)obj pvt_print] ;
//    
//    NSMutableArray *arr = [NSMutableArray array] ;
//    [arr addObject:@"123"];
//    [arr addObject:nil];
    
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"ray",@"name",@30,@"age", nil] ;
    
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"ray",@"name", nil] ;

    
    NSMutableDictionary *dict3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"ray",@"name",@30,@"age", nil];
    
    
    [dict objectForKey:@"namedd"];
    
    [dict3 objectForKey:@"name"];

    
    dict3[@"wight"] = @60 ;
//    [dict3 setObject:nil forKey:@"height"] ;
//    [dict3 setObject:@"23" forKey:@""] ;

    
    [dict3 objectForKey:nil];
    
}

-(void)pvt_click{
    
    
    
    
    
    KLTestRuntimer *test =  [KLTestRuntimer new] ;
    [test pvt_test] ;
    [KLTestRuntimer pvt_classtest] ;
    
    [KLFloatView show];
    
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
 
   
    
    
    
 }


 
@end
