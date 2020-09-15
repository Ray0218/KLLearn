//
//  KLRecommendGameView.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/1.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit


 
class KLRecommendGameView: UIView {
    
    
    //MARK:懒加载
    lazy var rCollectionView : UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: kGameViewH)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0 //行间距
        layout.scrollDirection = .horizontal
        
        let collectioview = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectioview.delegate = self
        collectioview.dataSource = self
        collectioview.showsHorizontalScrollIndicator = false
        
        collectioview.register(KLRecomGameCollectionCell.self, forCellWithReuseIdentifier: kNormalCellId)
        collectioview.backgroundColor = .white
        collectioview.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return collectioview
        }()
    
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    var  rAnchGroups : [KLBaseGameModel]?{
        
        didSet {
            
            self.rCollectionView.reloadData()
            
        }
    }
}


extension KLRecommendGameView {
    
    func  setupUI ()  {
        
        addSubview(rCollectionView)
        
    }
}


extension KLRecommendGameView : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rAnchGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! KLRecomGameCollectionCell
        //         cell.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g:CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
        
        
        cell.rAnchGroup = self.rAnchGroups![indexPath.item]
        return cell
    }
    
    
}
