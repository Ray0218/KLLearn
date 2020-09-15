//
//  KLNetWorkTools.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/31.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class KLNetWorkTools {
    
    class  func requestData(type:MethodType,URLString:String ,parameters:[String : Any]? = nil, finishedCallBack:@escaping( _ result : Any) -> ()){
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        
        Alamofire.request(URLString,method: method,parameters: parameters).responseJSON { (response) in
            
            
            guard let data = response.result.value  else{
                
                print(response.result.error as Any)
                
                return
            }
            
            finishedCallBack(data)
        }
        
        
        
    }
    
}
