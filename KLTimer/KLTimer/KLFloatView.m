//
//  KLFloatView.m
//  KLTimer
//
//  Created by WKL on 2019/11/13.
//  Copyright © 2019 Ray. All rights reserved.
//

#import "KLFloatView.h"
#import "TimeViewController.h"
#import "KLAnimator.h"


@interface KLFloatView ()<UINavigationControllerDelegate>{
    
    CGPoint rLastPoint;
    
    CGPoint rPointInSelf;
    
    
}

@end

@implementation KLFloatView


static KLFloatView *rFloatView;

static UIView *rCircleView;


+(void)show{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rFloatView = [[KLFloatView alloc]initWithFrame:CGRectMake(10, 200, 60, 60)];
        
        rCircleView = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 80, [UIScreen mainScreen].bounds.size.height - 80, 80, 80)];
        rCircleView.backgroundColor = [UIColor orangeColor];
    });
    
    if (!rCircleView.superview) {
           [[UIApplication sharedApplication].keyWindow addSubview:rCircleView];
           [[UIApplication sharedApplication].keyWindow bringSubviewToFront:rCircleView];
       }
       
    
    if (!rFloatView.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:rFloatView];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:rFloatView];
    }
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor purpleColor];
        self.layer.contents = (__bridge id)([UIImage imageNamed:@"dd"].CGImage);
        
    }
    return self;
}


#pragma touch

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    rLastPoint = [touch locationInView:self.superview];
    rPointInSelf = [touch locationInView:self];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint rCurrentPoint = [[touches anyObject] locationInView:self.superview];
    
    if (CGPointEqualToPoint(rLastPoint, rCurrentPoint)) {
        UINavigationController *nvc = (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController ;
        nvc.delegate = self;
        
        
        if ([nvc.topViewController isKindOfClass:[TimeViewController class]]) {
            return ;
        }
        TimeViewController *vc = [[TimeViewController alloc]init];
           [nvc pushViewController:vc animated:YES];
        
        
        
        return;
    }
    
    if (self.center.x > [UIScreen mainScreen].bounds.size.width - 80 && self.center.y > [UIScreen mainScreen].bounds.size.height - 80) {
        
         [self removeFromSuperview];
    }
    
    
//    隐藏
    [UIView animateWithDuration:.2f animations:^{
        rCircleView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, 80, 80);
        
    }];
       
    
    //离左右的间距
    CGFloat leftMargin = self.center.x ;
    CGFloat rightMargin = [UIScreen mainScreen].bounds.size.width - leftMargin;
    
    NSLog(@"left = %.2f, right= %.2f",leftMargin,rightMargin);

    if (leftMargin < rightMargin) {
        
        
        [UIView animateWithDuration:0.2f animations:^{
            self.center = CGPointMake(40, self.center.y);
            
        }];
    }else{
        
        [UIView animateWithDuration:0.2f animations:^{
            self.center = CGPointMake( [UIScreen mainScreen].bounds.size.width- 40, self.center.y);
            
        }];
    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint rCurrentPoint = [[touches anyObject] locationInView:self.superview];
    
    
    if (CGRectEqualToRect(rCircleView.frame, CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, 80, 80))) {
            
        rCircleView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-80, [UIScreen mainScreen].bounds.size.height-80, 80, 80);
    }
    
    
    
    CGFloat centerX = rCurrentPoint.x +  (self.frame.size.width/2 - rPointInSelf.x);
    CGFloat centerY = rCurrentPoint.y +  (self.frame.size.height/2 - rPointInSelf.y);
    
    
    
    CGFloat x = MAX(30, MIN([UIScreen mainScreen].bounds.size.width - 30, centerX));
    CGFloat y = MAX(30, MIN([UIScreen mainScreen].bounds.size.height - 30, centerY));
    
    self.center = CGPointMake(x, y);
    
}

#pragma mark uinavigation delegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    
    
    if (operation == UINavigationControllerOperationPush) {
         
        KLAnimator *animator = [KLAnimator new];
        animator.rCurrentFrame = self.frame;
        
        return animator;
    }
    
    return nil ;
}

@end
