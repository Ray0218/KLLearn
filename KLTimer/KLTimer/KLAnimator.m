//
//  KLAnimator.m
//  KLTimer
//
//  Created by WKL on 2019/11/13.
//  Copyright © 2019 Ray. All rights reserved.
//

#import "KLAnimator.h"

@implementation KLAnimator



- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containView = transitionContext.containerView ;
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey] ;
    
    [containView addSubview:toView];
    
     
    KLAnimatorView *animatorView = [[KLAnimatorView alloc]initWithFrame:toView.bounds];
    
    [containView addSubview:animatorView];
    
    //截屏
    UIGraphicsBeginImageContext(toView.frame.size);
    [toView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    animatorView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    toView.hidden = YES ;
    
    //animatorView 是从floatView
    [animatorView startAnimateWhitView:toView fromRect:self.rCurrentFrame toREct:toView.frame];
   
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         //移除fromeview fromViewController
          [transitionContext completeTransition:YES];
          
    });
 
    
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return  1.f;
}

@end


@interface KLAnimatorView()<CAAnimationDelegate>{
    CAShapeLayer *rShapLayer;
    
    UIView *toView ;
}

@end
@implementation KLAnimatorView

-(void)startAnimateWhitView:(UIView*)theView fromRect:(CGRect)fromRect toREct:(CGRect)toRect{
    
    toView = theView ;
    
    //mask 和floatView大小一致的mask
    
    rShapLayer = [CAShapeLayer layer] ;
    rShapLayer.path = [UIBezierPath bezierPathWithRoundedRect:fromRect cornerRadius:30].CGPath;
    self.layer.mask = rShapLayer;
    
    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"path"];
    anima.toValue = (__bridge id _Nullable)([UIBezierPath bezierPathWithRoundedRect:toRect cornerRadius:30].CGPath);
    anima.duration = .5;
    anima.fillMode = kCAFillModeForwards;
    anima.removedOnCompletion = NO;
    anima.delegate = self;
    [rShapLayer addAnimation:anima forKey:nil];
    
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    toView.hidden = NO;
    [rShapLayer removeAllAnimations];
    [self removeFromSuperview];
}

@end
