//
//  KLAmuseMenueView.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/2.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit


fileprivate let kMenueCellId = "kMenueCellId"


class KLAmuseMenueView: UIView {
    
    fileprivate lazy var rPageControl : UIPageControl = {
        
        let pageContrl = UIPageControl()
        
        pageContrl.currentPageIndicatorTintColor = .orange
        pageContrl.pageIndicatorTintColor = .white
        
        pageContrl.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        pageContrl.numberOfPages = 2
        return pageContrl
    }()
    
    
    
    private lazy var rCollectionView : UICollectionView = { [unowned self] in
        
        
        print("bounds ==" ,self.bounds)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenW, height: self.bounds.height - 20)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0 //行间距
        layout.scrollDirection = .horizontal
        
        
        let collectioview = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        
        collectioview.dataSource = self
        collectioview.delegate = self
        
        collectioview.register(KLMenueCell.self, forCellWithReuseIdentifier: kMenueCellId)
        
        collectioview.backgroundColor = .white
        
        collectioview.showsHorizontalScrollIndicator = false
        collectioview.showsVerticalScrollIndicator = false
        collectioview.isPagingEnabled = true
        
        
        return collectioview
        }()
    
    
    var rGroups : [KLAnchorGroup]? {
           
        didSet{
            
            self.rCollectionView.reloadData()
            
        }
       }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}

extension KLAmuseMenueView {
    
    func  setupUI ()  {
        
        addSubview(rCollectionView)
        
        addSubview(rPageControl)
        
        rCollectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(rPageControl.snp_top)
        }
        
        rPageControl.snp.makeConstraints { (make) in
            make.centerX.bottom.width.equalToSuperview()
            make.height.equalTo(20)
        }
        
    }
}


extension KLAmuseMenueView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let count = self.rGroups?.count else {
            
            return 0
        }
        let num = (count  - 1) / 8 + 1
        rPageControl.numberOfPages = num
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenueCellId, for: indexPath) as! KLMenueCell
        
        setupCellDataWithCell(cell: cell, indexpath: indexPath)
        
 
        return cell
    }
    
    
    func setupCellDataWithCell(cell : KLMenueCell, indexpath: IndexPath)  {
        
        
//        0页 0 ~7
//        1页 7 ~ 15
        let startIndex = indexpath.item * 8
        var  endIndex = (indexpath.item + 1)*8 - 1
         
        
        if endIndex > rGroups!.count - 1{
            
            endIndex = rGroups!.count - 1
        }
        
        cell.rGroups = Array(rGroups![startIndex...endIndex])
    }
    
}


extension KLAmuseMenueView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         
                 rPageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
