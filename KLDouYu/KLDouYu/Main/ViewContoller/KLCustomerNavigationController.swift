//
//  KLCustomerNavigationController.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/3.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLCustomerNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //获取系统pod手势
        guard let systemGes = interactivePopGestureRecognizer else {
            return
        }
        //获取手势对应的View
        guard let gesView = systemGes.view else {
            return
        }
        
        /*
         var count : UInt32 = 0
         let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
         
         for i in 0...count {
         let ivar = ivars[Int(i)]
         
         let name = ivar_getName(ivar)!
         
         print(String(cString: name))
         }
         */
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        
        guard let targetObjc = targets?.first else {
            return
        }
        
        print(targetObjc)
        
        guard  let target = targetObjc.value(forKey: "target") else {return}
        let action = Selector(("handleNavigationTransition:"))
        
        
        let panGesture = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGesture)
        panGesture.addTarget(target, action: action)
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
