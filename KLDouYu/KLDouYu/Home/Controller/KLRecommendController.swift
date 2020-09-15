//
//  KLRecommendController.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/29.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit



//MARK: 常量


private let kItemMargin: CGFloat = 10

private let kItemW = (kScreenW - 3*kItemMargin)/2
private let kNormalItemH = (kItemW*3)/4

private let kPertyItemH = (kItemW*5)/5

private let kHeaderH : CGFloat = 50

let kScyleViewH : CGFloat = kScreenW*3/8
let kGameViewH : CGFloat =  90



class KLRecommendController: KLAnchorBaseController {
    
    
    lazy var rScyleView : KLRecommendSycleView  = {
        
        
        let sycleView = KLRecommendSycleView(frame: CGRect(x: 0, y: -kScyleViewH - kGameViewH, width: kScreenW, height: kScyleViewH))
        
        return sycleView
        
    }()
    
    
    
    private  lazy var rGameView : KLRecommendGameView  = {
        
        
        let sycleView = KLRecommendGameView(frame: CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH))
        
        return sycleView
        
    }()
    
    private  let rRecViewMode: KLRecommendViewModel = KLRecommendViewModel()
    
    
    
    override   func loadData ()  {
        
        rViewModel = rRecViewMode
        rRecViewMode.requestData {
            
            self.rCollectionView.reloadData()
            
            
            var  groups = self.rViewModel.rAnchorGroups as [KLAnchorGroup]
            
            
            groups.removeFirst()
            
            groups.removeFirst()
            
            
            //添加更多
            let moreGroup = KLAnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            
            self.rGameView.rAnchGroups = groups
            
            self.rCollectionView.reloadData()
            
            
            self.loadDataFinish()
            
        }
        
        rRecViewMode.requestCycleData {
            
            self.rScyleView.rModelsArr = self.rRecViewMode.rCycleModels
        }
    }
    
    
    override func setupUI()  {
        
        self.rCollectionView.contentInset = UIEdgeInsets(top: kScyleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        self.rCollectionView.delegate = self
        super.setupUI()
        rCollectionView.addSubview(rScyleView)
        rCollectionView.addSubview(rGameView)
        
    }
    
}




//MARK:- UICollectionViewDataSource

extension KLRecommendController {
 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let group = self.rViewModel.rAnchorGroups[indexPath.section] as KLAnchorGroup
        
        let anchorModel = group.anchors[indexPath.item]
        
        if indexPath.section == 1{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPerttyCellId, for: indexPath) as! KLPrettyCollectionCell
            cell.rAnchor = anchorModel
            
            return cell
            
        }
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! KLNormalCollectionCell
        cell.rAnchor = anchorModel
        return cell
        
    }
    
    
}


//MARK: -UICollectionViewDelegate
extension KLRecommendController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPertyItemH)
        }else{
            return CGSize(width: kItemW, height: kNormalItemH)
            
        }
    }
}



