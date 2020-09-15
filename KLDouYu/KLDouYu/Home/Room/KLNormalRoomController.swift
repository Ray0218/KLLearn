//
//  KLNormalRoomController.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/3.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit
import BMPlayer
import IJKMediaFramework

class KLNormalRoomController: KLBaseViewController,UIGestureRecognizerDelegate {

    lazy var rPlayer : BMPlayer = {
        
        let player = BMPlayer()
        
        
        return player
    }()
    
    
    var rijkPlayer : IJKFFMoviePlayerController?
    
  
       
    
    var rAnchor : KLAnchorModel? {
        
        didSet{
            
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .orange
        
//        view.addSubview(rPlayer)
//
//        rPlayer.snp_makeConstraints { (make) in
//            make.top.equalTo(self.view).offset(20)
//            make.left.right.equalTo(self.view)
//            // 注意此处，宽高比 16:9 优先级比 1000 低就行，在因为 iPhone 4S 宽高比不是 16：9
//                make.height.equalTo(rPlayer.snp_width).multipliedBy(9.0/16.0).priority(750)
//        }
//        rPlayer.backBlock = { [unowned self] (isFullScreen) in
//            let _ = self.navigationController?.popViewController(animated: true)
//        }
        
        
        
//        let url  =   "douyuapp://room?liveType=0&mid=1&rid=3544169&roomSrc=https%3A%2F%2Frpic.douyucdn.cn%2Flive-cover%2FroomCover%2Fcover_update%2F2020%2F09%2F01%2F7165f19f3d887c1f4c4602f4c09db5b9.jpg%2Fdy1&tpl="
                   
                   
                   
        
//          let  url = "http://tc-tct.douyucdn2.cn/dyliveflv3/5920858rmRpFtEVR.flv?wsAuth=4f5cc20748272a3287c73a6616a7e92d&token=app-ios-0-5920858-09dd129c1bb903aee7806b3bf91e49432693d5aef502b885&logo=0&expire=0&did=cc76d0c6dc4b0b1b7921258500001521&ver=6.320&pt=1&st=0&origin=tct&mix=0&isp="
//
        let url = "ikqc://wssource.quic.inke.cn:9000/live/1599287742528920_0.flv?auth_version=2&codecInfo=8192&dpSrc=20&from=hallfe&ikBkUrl=http%3A%2F%2Fwssource.edge.inke.cn%2Flive%2F1599287742528920_0.flv%3Fauth_version%3D2%26codecInfo%3D8192%26from%3Dhallfe%26ikChorus%3D1%26ikDnsOp%3D1001%26ikFastRate%3D1.1%26ikHost%3Dws%26ikLiveType%3Dnormal%26ikLog%3D1%26ikMaxBuf%3D3600%26ikMinBuf%3D2900%26ikOp%3D0%26ikPullHevc%3D1%26ikSlowRate%3D0.9%26ikSyncBeta%3D1%26md5sum%3D35a5%26msSmid%3DD2SfG7UNJ3N3HfRm9j3qDi9NyYWH2Iz%252BjuUG7BadHTvZ4Xe7%26msUid%3D2049852887%26timestamp%3D1599290471&ikChorus=1&ikDnsOp=1001&ikFastRate=1.1&ikHost=ws&ikLiveType=normal&ikLog=1&ikMaxBuf=3600&ikMinBuf=2900&ikOp=0&ikPullHevc=1&ikQSessionLive=30&ikSlowRate=0.9&ikSyncBeta=1&md5sum=35a5&msSmid=D2SfG7UNJ3N3HfRm9j3qDi9NyYWH2Iz%2BjuUG7BadHTvZ4Xe7&msUid=2049852887&pushHost=clsTrans.push.cls.inke.cn&timestamp=1599290471"
                  
                 let player = IJKFFMoviePlayerController(contentURL: URL(string: url), with: nil)
                               
                               self.view.insertSubview((player?.view)!, at: 0)
                               player?.view.snp.makeConstraints({ (make) in
                   
                                    make.edges.equalToSuperview()
                               
                                   
                               })
                               self.rijkPlayer = player
                               player?.prepareToPlay()
                               player?.play()
        
        return
        
        
                          
        
        let urlString = "http://service.inke.com/api/live/simpleall?&gender=1&gps_info=116.346844%2C40.090467&loc_info=CN%2C%E5%8C%97%E4%BA%AC%E5%B8%82%2C%E5%8C%97%E4%BA%AC%E5%B8%82&is_new_user=1&lc=0000000000000053&cc=TG0001&cv=IK4.0.30_Iphone&proto=7&idfa=D7D0D5A2-3073-4A74-A726-98BE8B4E8F38&idfv=58A18E13-A21D-456D-B6D8-7499948B379D&devi=54b68af1895085419f7f8978d95d95257dd44f93&osversion=ios_10.300000&ua=iPhone6_2&imei=&imsi=&uid=450515766&sid=20XNNoa5VwMozGALfmi2xN1YCfLWvEq7aJuTHTQLu8bT88i1aNbi0&conn=wifi&mtid=391bb3520c38e0444ba0b3975f4bb1aa&mtxid=f0b42913a33c&logid=162,210&s_sg=3111b3a0092d652ab3bcb218099968de&s_sc=100&s_st=1492954889"
                   
                   
                   
        
        KLNetWorkTools.requestData(type: .GET, URLString: urlString) { ( respo) in
            
            print(respo)
            guard let dict = respo as? [String: Any] else {return}
            
            guard let lives = dict["lives"] as? [[String : Any]] else {return}
        
            
            guard let liveDic = lives.first else {return}
            
            guard let str = liveDic["stream_addr"] as? String else {return}

let player = IJKFFMoviePlayerController(contentURL: URL(string: str), with: nil)
            
            self.view.insertSubview((player?.view)!, at: 0)
            player?.view.snp.makeConstraints({ (make) in
//                 make.top.equalTo(self.view).offset(20)
//                            make.left.right.equalTo(self.view)
//                            // 注意此处，宽高比 16:9 优先级比 1000 低就行，在因为 iPhone 4S 宽高比不是 16：9
//                make.height.equalTo((player?.view.snp_width)!).multipliedBy(9.0/16.0).priority(750)
                
                make.edges.equalToSuperview()
            
                
            })
            self.rijkPlayer = player
            player?.prepareToPlay()
            player?.play()
 
        }

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
