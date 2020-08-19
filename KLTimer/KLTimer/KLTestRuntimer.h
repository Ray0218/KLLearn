//
//  KLTestRuntimer.h
//  KLTimer
//
//  Created by WKL on 2020/8/19.
//  Copyright © 2020 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLTestRuntimer : NSObject


-(void)pvt_test;

+(void)pvt_classtest;

@end


@interface KLOtherPerson : NSObject

-(void)pvt_test;
+(void)pvt_classtest;


@end

NS_ASSUME_NONNULL_END
