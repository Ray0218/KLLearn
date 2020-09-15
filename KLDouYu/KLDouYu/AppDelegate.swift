//
//  AppDelegate.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/28.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
//        application.statusBarStyle = .lightContent
        UITabBar.appearance().tintColor = .orange
        
        window = UIWindow.init(frame: UIScreen.main.bounds) ;
            window?.rootViewController = KLTabBarController.init() ;
        window?.backgroundColor = .white ;
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle
 


}

