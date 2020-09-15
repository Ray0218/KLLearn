//
//  KLBaseViewController.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/3.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLBaseViewController: UIViewController,UINavigationControllerDelegate {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationController?.delegate = self
        
        //防止滑动返回导航栏隐藏的问题
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    func needHiddenNvigationBar(controller : UIViewController) -> Bool {
        
        var need = false
        
        if controller.isKind(of: KLNormalRoomController.self) {
            need = true
        }
        return need
        
    }
    
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        navigationController.setNavigationBarHidden(needHiddenNvigationBar(controller: viewController), animated: animated)
        
    }
    
}
