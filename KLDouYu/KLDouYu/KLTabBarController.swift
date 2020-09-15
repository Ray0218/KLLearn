//
//  KLTabBarController.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/28.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLTabBarController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let rHome = KLHomeController.init()
        
        rHome.tabBarItem.selectedImage = UIImage.init(named: "btn_home_selected")
        rHome.tabBarItem.image = UIImage.init(named: "btn_home_normal")
        rHome.tabBarItem.title = "首页"
        
        let rLive = KLLiveController.init()
        rLive.tabBarItem.selectedImage = UIImage.init(named: "btn_live_selected")
        rLive.tabBarItem.image = UIImage.init(named: "btn_live_normal")
        rLive.tabBarItem.title = "直播"
        
        let rAttention = KLAttentionController.init()
        
        rAttention.tabBarItem.selectedImage = UIImage.init(named: "btn_column_selected")
        rAttention.tabBarItem.image = UIImage.init(named: "btn_column_normal")
        rAttention.tabBarItem.title = "关注"
        
        let rMy = KLMyController.init()
        
        rMy.tabBarItem.selectedImage = UIImage.init(named: "btn_user_selected")
        rMy.tabBarItem.image = UIImage.init(named: "btn_user_normal")
        rMy.tabBarItem.title = "我的"
        
        
        
        viewControllers = [KLCustomerNavigationController.init(rootViewController: rHome),UINavigationController.init(rootViewController: rLive),
                           UINavigationController.init(rootViewController: rAttention),
                           UINavigationController.init(rootViewController: rMy)]
        
        
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
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
