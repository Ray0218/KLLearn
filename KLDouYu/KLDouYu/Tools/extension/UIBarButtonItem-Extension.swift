//
//  UIBarButtonItem-Extension.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/29.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    
    class  func createItem(imageName:String,highImageName:String,size:CGSize) -> UIBarButtonItem {
        
        let historyBtn = UIButton()
        historyBtn.setImage(UIImage(named: imageName), for: .normal)
        historyBtn.setImage(UIImage(named: highImageName), for: .highlighted)
        
        historyBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem.init(customView: historyBtn)
        
    }
    
    //便利构造函数
    convenience init(imageName:String,highImageName:String = "",size:CGSize = .zero) {
        
        let historyBtn = UIButton()
        historyBtn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            historyBtn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size != .zero {
            historyBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        }else{
            historyBtn.sizeToFit()
        }
        self.init(customView:historyBtn)
        
    }
    
     
}
