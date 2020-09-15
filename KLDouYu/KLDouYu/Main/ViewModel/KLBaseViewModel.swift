//
//  KLBaseViewModel.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/2.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLBaseViewModel {
    
    
    //MARK:懒加载属性
    
    lazy var rAnchorGroups : [KLAnchorGroup] = [KLAnchorGroup]()
}


extension KLBaseViewModel {
    
    func  requestAnchorData(isGroup : Bool, urlString: String,parameters: [String: Any]?, finsishCAllBack:@escaping () -> ())  {
        
        KLNetWorkTools.requestData(type: .GET, URLString: urlString,parameters: parameters) { (response) in
            
 
            // 1.将result转成字典类型
            guard let resultDict = response as? [String : NSObject] else { return }
            
            
            guard let dataArr = resultDict["data"] as? [[String: NSObject]] else {return}
            
            
            if isGroup{
            let modes = dataArr.map { (json) -> KLAnchorGroup in
                return  KLAnchorGroup(dict:json)
            }
            
            self.rAnchorGroups.append(contentsOf: modes)
            }else {
                
                
                let group = KLAnchorGroup()
                
                let anchors = dataArr.map { (jsons) -> KLAnchorModel in
                    return KLAnchorModel(dict: jsons)
                }
                
                group.anchors.append(contentsOf: anchors)
                
                self.rAnchorGroups.append(group)
            }
            
            finsishCAllBack()
            
        }
        
    }
    
    
    func requesFunData( finish : @escaping () -> ()) {
 
        
        requestAnchorData(isGroup: false, urlString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/2", parameters: ["limit" : 30, "offset" : 0],finsishCAllBack: finish)
        
    }
}
