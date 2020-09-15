//
//  KLAmuseViewModel.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/2.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLAmuseViewModel: KLBaseViewModel {

  
    
    
}

extension KLAmuseViewModel {
    
 
    func requestAmuseData(result:@escaping () -> ())  {
         
        
//        KLNetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2",parameters: ["version" : "2.300"]) { (response) in
//
//
//            // 1.将result转成字典类型
//                     guard let resultDict = response as? [String : NSObject] else { return }
//
//            guard let dataArr = resultDict["data"] as? [[String: NSObject]] else {return}
//
//
//
//            let modes = dataArr.map { (json) -> KLAnchorGroup in
//                 return  KLAnchorGroup(dict:json)
//            }
//
//            self.rAnchorGroups.append(contentsOf: modes)
//
// result()
        
        
        
//         }
        
        requestAnchorData(isGroup: true, urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: ["version" : "2.300"], finsishCAllBack: result)
        
        
    }
}
