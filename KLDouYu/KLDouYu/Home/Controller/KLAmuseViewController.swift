//
//  KLAmuseViewController.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/2.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit



let kMenueH : CGFloat = 173 + 20

class KLAmuseViewController: KLAnchorBaseController {
    
    lazy var rAmuseVN : KLAmuseViewModel = KLAmuseViewModel()
    
    lazy var rMenueView : KLAmuseMenueView = {
        
        let view = KLAmuseMenueView(frame: CGRect(x: 0, y: -kMenueH, width: kScreenW, height: kMenueH))
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func loadData() {
        
        rViewModel = rAmuseVN
        
        rAmuseVN.requestAmuseData {
            
            self.rCollectionView.reloadData()
            
            
            var tempGroup = self.rViewModel.rAnchorGroups
            
            tempGroup.removeFirst()
            self.rMenueView.rGroups = tempGroup
            
            self.loadDataFinish()

        }
        
    }
    
    
    override func setupUI() {
        
        rCollectionView.contentInset = UIEdgeInsets(top: kMenueH, left: 0, bottom: 0, right: 0)
        super .setupUI()
        
        
        rCollectionView.addSubview(rMenueView)
    }
    
}



