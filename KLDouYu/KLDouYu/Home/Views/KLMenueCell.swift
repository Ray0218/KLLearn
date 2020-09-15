//
//  KLMenueCell.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/2.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit


private let kItemW : CGFloat = (kScreenW  )/4

private let kItemH : CGFloat = 86

private let kGamesCellId = "kGamesCellId"


class KLMenueCell: UICollectionViewCell {
    
    //MARK:懒加载
    private lazy var rCollectionView : UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0 //行间距
        
        let collectioview = UICollectionView(frame: self.contentView.bounds, collectionViewLayout: layout)
        //          collectioview.delegate = self
        collectioview.dataSource = self
        
        
        collectioview.register(KLGameCollectionCell.self, forCellWithReuseIdentifier: kGamesCellId)
        
        collectioview.backgroundColor = .white
        
        
        return collectioview
        }()
    
    
    var rGroups : [KLAnchorGroup]? {
        
        didSet{
            
            self.rCollectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(rCollectionView)
        rCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension KLMenueCell : UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.rGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGamesCellId, for: indexPath) as! KLGameCollectionCell
        
        cell.rAnchGroup = self.rGroups![indexPath.item]
        return cell
    }
    
}
