//
//  KLAnchorBaseController.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/2.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit



  let kHeaderReuseId = "kHeaderReuseId"
  let kNormalCellId = "kNormalCellId"
  let kPerttyCellId = "kPerttyCellId"

private let kItemMargin: CGFloat = 10
private let kHeaderH : CGFloat = 50

private let kItemW = (kScreenW - 3*kItemMargin)/2
private let kNormalItemH = (kItemW*3)/4


class KLAnchorBaseController: KLHomeBaseController {
    
    //MARK:懒加载
    
  var rViewModel : KLBaseViewModel!
    
    lazy var rCollectionView : UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumInteritemSpacing = kItemMargin
        layout.minimumLineSpacing = 0 //行间距
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectioview = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
                collectioview.delegate = self
        collectioview.dataSource = self
        
        
        collectioview.register(KLNormalCollectionCell.self, forCellWithReuseIdentifier: kNormalCellId)
        collectioview.register(KLPrettyCollectionCell.self, forCellWithReuseIdentifier: kPerttyCellId)

        collectioview.register(KLRecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderReuseId)
        collectioview.backgroundColor = .white
        
        collectioview.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        //        collectioview.contentInset = UIEdgeInsets(top: kScyleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        return collectioview
        }()
    
    
   
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
         setupUI()
        
        loadData()
 

    }
   
    
    func loadData ()  {

       }
    
    
    override func setupUI()  {
           view.addSubview(rCollectionView)
        rContentView = rCollectionView
        
        super.setupUI()

        }
    
}


 
 


//MARK:- UICollectionViewDataSource

extension KLAnchorBaseController : UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        let group = self.rViewModel.rAnchorGroups
        return group.count
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = self.rViewModel.rAnchorGroups[section]
        return group.anchors.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let group = self.rViewModel.rAnchorGroups[indexPath.section] as KLAnchorGroup
        
        let anchorModel = group.anchors[indexPath.item]
        
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! KLNormalCollectionCell
        cell.rAnchor = anchorModel
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let header =   collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: kHeaderReuseId, for: indexPath) as! KLRecommendHeaderView
        
        let group = rViewModel.rAnchorGroups[indexPath.section]
        
        header.rAnchorGroup = group
        
        return header
        
    }
    
}



extension KLAnchorBaseController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
        
        let anchor = rViewModel.rAnchorGroups[indexPath.section].anchors[indexPath.row]
        
        anchor.isVertical == 0 ? pushNormalRoomVC(anchor: anchor) : presentShowRoomVC(anchor: anchor)
    }
    
    
    func presentShowRoomVC(anchor: KLAnchorModel)  {
         
         present(KLShowRoomController(), animated: true) {
             
        }
    }
    
    func pushNormalRoomVC(anchor: KLAnchorModel)  {
        
 
        navigationController?.pushViewController(KLNormalRoomController(), animated: true)
    }
    
    
}



