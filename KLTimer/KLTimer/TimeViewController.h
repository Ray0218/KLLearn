//
//  TimeViewController.h
//  KLTimer
//
//  Created by WKL on 2019/11/12.
//  Copyright © 2019 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeViewController : UIViewController

@end




@interface KLTargetObject : NSObject

@property (nonatomic, weak, nullable) id  target;
+(instancetype)initWithTarget:(id)target;

@end



@interface KLProxy : NSProxy //专门做消息转发
@property (nonatomic, weak, nullable) id  target;
+(instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
