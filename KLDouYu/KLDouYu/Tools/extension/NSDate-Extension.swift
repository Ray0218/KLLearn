//
//  NSDate-Extension.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/31.
//  Copyright © 2020 ray. All rights reserved.
//

import Foundation


extension Date{
    
    
   static  func getCurrentTime() -> String {
    
    let nowDate = Date()
    let timeInterval = Int(nowDate.timeIntervalSince1970)
    return "\(timeInterval)"
         
    }
    
}
