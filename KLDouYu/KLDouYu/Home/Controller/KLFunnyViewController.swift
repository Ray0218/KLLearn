//
//  KLFunnyViewController.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/2.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLFunnyViewController: KLAnchorBaseController {

    
    lazy var rFunViewModel : KLBaseViewModel = KLBaseViewModel()
    

    override func loadData() {
        
        rViewModel = rFunViewModel
        
        rFunViewModel.requesFunData {
            
            self.rCollectionView.reloadData()
            
            self.loadDataFinish()

        }
         
    }
    
    
    override func setupUI() {
         
        super.setupUI()
        
        let layout = rCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.headerReferenceSize = CGSize.zero
        rCollectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        
    }
    
}
