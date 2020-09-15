//
//  KLAnchorGroup.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/31.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

//通过setValuesForKeys保存字典数据
//在swift3中，编译器自动推断@objc，换句话说，它自动添加@objc
//在swift4中，编译器不再自动推断，你必须显式添加@objc
@objcMembers

class KLBaseGameModel: NSObject {
    // MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    // MARK:- 自定义构造函数
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

class KLAnchorGroup: KLBaseGameModel {
    
    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(KLAnchorModel(dict: dict))
            }
        }
    }
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    /// 定义主播的模型对象数组
    lazy var anchors : [KLAnchorModel] = [KLAnchorModel]()
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

@objcMembers
class KLAnchorModel : NSObject {
    
    // MARK:- 自定义构造函数
    override init() {
        
    }
    /// 房间ID
    var room_id : Int = 0
    /// 房间图片对应的URLString
    var vertical_src : String = ""
    /// 判断是手机直播还是电脑直播
    // 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
    var isVertical : Int = 0
    /// 房间名称
    var room_name : String = ""
    /// 主播昵称
    var nickname : String = ""
    /// 观看人数
    var online : Int = 0
    /// 所在城市
    var anchor_city : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    var rOnline : String {
        
        if online > 10000{
            return "\(Int(online/10000))万"
        }
        
        return "\(online)"
    }
    
    
}
