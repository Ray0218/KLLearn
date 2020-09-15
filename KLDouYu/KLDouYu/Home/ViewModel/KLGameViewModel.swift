//
//  KLGameViewModel.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/2.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLGameViewModel {
    
    lazy var rGames : [KLBaseGameModel] = [KLBaseGameModel]()

}



extension KLGameViewModel {
    
    func requestData(finishCallBack: @escaping () -> ())  {
         
        
        KLNetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail") { (response) in
             
            
            guard let resultDict = response as? [String : Any] else {return}
            
            guard let array = resultDict["data"] as? [[String : Any]] else {return}
            
          let modes =  array.map { (json) -> KLBaseGameModel in
                 
                return KLBaseGameModel(dict: json)
            }
            
            
             self.rGames.append(contentsOf: modes)
            finishCallBack()
            
        }
        
    }
    
}
