//
//  KLAnimator.h
//  KLTimer
//
//  Created by WKL on 2019/11/13.
//  Copyright © 2019 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

 
@interface KLAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign)  CGRect rCurrentFrame;

@end

 


@interface KLAnimatorView : UIImageView


-(void)startAnimateWhitView:(UIView*)theView fromRect:(CGRect)fromRect toREct:(CGRect)toRect;

@end


