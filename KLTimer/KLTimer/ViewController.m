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
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary] ;
    [dict setValue:@"dd" forKey:@"key1"];
    [dict setValue:@"cc" forKey:@"key2"];
    
   NSString *rer =  AFQueryStringFromParameters(dict) ;
    
    
 
    NSLog(@"%@",rer);
    
}

-(void)pvt_click{
    
    
   KLTestRuntimer *test =  [KLTestRuntimer new] ;
    
    [test pvt_test] ;
    [KLTestRuntimer pvt_classtest] ;
    
    [KLFloatView show];

}


@end
