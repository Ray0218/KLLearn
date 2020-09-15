//
//  UINavigationController-Extern.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/3.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit


extension UINavigationController {
    
    
    public class  func  initializeMethod(){
        
        
        
        let originalSelector = #selector(pushViewController(_:animated:))
        let swizzledSelector = #selector( klpushViewController(_:animated:))
        
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        
        //在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
        let didAddMethod: Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
        
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
        
        
    }
    
    
    
    
    @objc func  klpushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if         viewControllers.count == 1
        {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        self.klpushViewController(viewController, animated: animated)
    }
    
    
}
