//
//  KLPageContentView.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/29.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class  {
    func PageContentView(contentView : KLPageContentView, progress: CGFloat, sourceIndex : Int , targetIndex : Int  )
}

private let contentCellId = "cellid"

class KLPageContentView: UIView {
    
    //MARK:定义属性
    
    private var rChildVCs : [UIViewController]
    private weak var rParentVC : UIViewController?
    private var rStartOffx : CGFloat = 0
    
    var rForbidScrollDelegate : Bool = false
    
    
    weak var delegate : PageContentViewDelegate?
    
    //MARK:懒加载属性
    
    lazy var rCollectionView : UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        
 
        let collection = UICollectionView.init(frame: self!.bounds, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.bounces = false
        collection.isPagingEnabled = true
        collection.dataSource = self
        collection.delegate = self
        
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellId)
        
        if #available(iOS 13.0, *) {
            collection.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            // Fallback on earlier versions
        }
        return collection
        }()
    
    
    //MARK:自定义构造函数
    init(frame: CGRect, childVCs : [UIViewController],parentController: UIViewController?) {
        
        self.rChildVCs = childVCs ;
        self.rParentVC = parentController ;
        
        super.init(frame: frame)
                
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




//MARK:- 设置UI

extension KLPageContentView {
    
    
    func setupUI (){
        
        
        //将子控制器添加到父控制器
        for childVC  in rChildVCs {
            rParentVC?.addChild(childVC)
        }
        
        //添加UICollectionView
        
        addSubview(rCollectionView)
        
    }
}


//MARK: -UICollectionViewDataSource
extension KLPageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rChildVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellId, for: indexPath)
        
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = rChildVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
    
    
}


extension KLPageContentView : UICollectionViewDelegate{
    
    
    //开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        rStartOffx = scrollView.contentOffset.x
        rForbidScrollDelegate = false
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if rForbidScrollDelegate {
            return
        }
        
        var progress : CGFloat = 0
        var  sourceIndex : Int = 0
        var  targetIndex : Int = 0
        
        let scrolW = scrollView.bounds.width
        
        let currentoffX = scrollView.contentOffset.x ;
        
        if currentoffX > rStartOffx { //左滑
            
            progress = currentoffX/scrolW - floor(currentoffX/scrolW)
            
            sourceIndex = Int(currentoffX/scrolW)
            
            targetIndex = sourceIndex + 1
            if targetIndex >= rChildVCs.count - 1 {
                targetIndex = rChildVCs.count - 1
            }
            //完全划过去
            if currentoffX - rStartOffx == scrolW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{ //右滑
            
            progress = 1 -  (currentoffX/scrolW - floor(currentoffX/scrolW))
            
            targetIndex =  Int(currentoffX/scrolW)
            
            sourceIndex = targetIndex + 1
            
            
            if sourceIndex >= rChildVCs.count - 1 {
                sourceIndex = rChildVCs.count - 1
            }
            
        }
        
        
        delegate?.PageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}


//MARK:- 对外暴露的方法

extension KLPageContentView {
    
    func setCurrentIndex(index: Int)  {
        
        rForbidScrollDelegate = true
        
        let offX = CGFloat(index) * rCollectionView.bounds.width
        
        rCollectionView.setContentOffset(CGPoint(x: offX, y: 0), animated: false)
        
    }
}
