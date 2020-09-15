//
//  KLRecommendViewModel.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/31.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit
import SwiftyJSON
//import HandyJSON


class KLRecommendViewModel : KLBaseViewModel {
    
    
    //MARK:懒加载属性
    
    
    lazy var rCycleModels : [KLCycleModel] = [KLCycleModel]()
    
    
    private lazy var bigDataGroup : KLAnchorGroup = KLAnchorGroup()
    
    private lazy var prettyGroup : KLAnchorGroup = KLAnchorGroup()
    
    
    
    
 
    
}

extension KLRecommendViewModel {
    
    
    func requestData( finshCallBack : @escaping( () -> ()))  {
        
        let dis_group = DispatchGroup()
        
        
        dis_group.enter()
        //请求推荐数据
        KLNetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom",parameters: ["time" : Date.getCurrentTime()]) { (result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = KLAnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            dis_group.leave()
        }
        
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        
        dis_group.enter()
        //请求颜值数据
        KLNetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom",parameters: parameters) { (result) in
            
            
            guard  let resultDic = result as? [String : AnyObject] else {return}
            
            guard let dataArray = resultDic["data"] as? [[String:Any]] else {return}
            
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            let modeArr =  dataArray.map { (jsons) -> KLAnchorModel in
                return KLAnchorModel(dict: jsons)
            }
            
            
            self.prettyGroup.anchors.append(contentsOf: modeArr)
            
            
            dis_group.leave()
        }
        
        dis_group.enter()
        
        requestAnchorData(isGroup: true, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            
            
            dis_group.leave()
            
        }
        
        //        //请求游戏数据
        //        KLNetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate",parameters: parameters) { (result) in
        //
        //
        //            guard  let resultDic = result as? [String : AnyObject] else {return}
        //
        //            guard let dataArray = resultDic["data"] as? [[String:Any]] else {return}
        //
        //            let modeArr =   dataArray.compactMap { (json) -> KLAnchorGroup? in
        //
        //                  return KLAnchorGroup(dict: json)
        //
        //            }
        //            self.rAnchorGroups.append(contentsOf: modeArr)
        //            dis_group.leave()
        //
        //        }
        
        
        dis_group.notify(queue: DispatchQueue.main) {
            
            self.rAnchorGroups.insert(self.prettyGroup, at: 0)
            self.rAnchorGroups.insert(self.bigDataGroup, at: 0)
            
            finshCallBack()
            
        }
        
    }
    
    
    func requestCycleData(result:@escaping () -> ())  {
        
        
        KLNetWorkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6",parameters: ["version" : "2.300"]) { (response) in
            
            
            // 1.将result转成字典类型
            guard let resultDict = response as? [String : NSObject] else { return }
            
            guard let dataArr = resultDict["data"] as? [[String: NSObject]] else {return}
            
            
            
            let modes = dataArr.map { (json) -> KLCycleModel in
                return  KLCycleModel(dict:json)
            }
            
            self.rCycleModels.append(contentsOf: modes)
            
            result()
        }
        
        
    }
}
