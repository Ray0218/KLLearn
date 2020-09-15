//
//  KLRecommendSycleView.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/1.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

 

class KLRecommendSycleView: UIView {
    
    
    //MARK:懒加载
    lazy var rCollectionView : UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenW, height: kScyleViewH)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0 //行间距
        layout.scrollDirection = .horizontal
        
        let collectioview = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectioview.delegate = self
        collectioview.dataSource = self
        collectioview.showsHorizontalScrollIndicator = false
        
        collectioview.register(KLCycleCollectionCell.self, forCellWithReuseIdentifier: kNormalCellId)
        
        collectioview.backgroundColor = .white
        
        collectioview.isPagingEnabled = true
        return collectioview
        }()
    
    
    fileprivate lazy var rPageControl : UIPageControl = {
        
        let pageContrl = UIPageControl()
        
        pageContrl.currentPageIndicatorTintColor = .orange
        pageContrl.pageIndicatorTintColor = .white
 
        return pageContrl
    }()
    
    
 private var rTimer : Timer?
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    var rModelsArr  : [KLCycleModel]? {
        
        
        didSet{
            
            self.rPageControl.numberOfPages = rModelsArr?.count ?? 0
            
            self.rCollectionView.reloadData()
            
            let indexpath = IndexPath(item: (rModelsArr?.count ?? 0)*10, section: 0)
            
            rCollectionView.scrollToItem(at: indexpath , at: .left, animated: false)
            
            removeTimer()
            addTimer()
        }
    }
    
     
    
}


extension KLRecommendSycleView {
    
    func  setupUI( )  {
        backgroundColor = .purple
        addSubview(rCollectionView)
        addSubview(rPageControl)
        
        
//        rCollectionView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
        
        rPageControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(rCollectionView).offset(-5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(20)
            make.width.equalTo(120)
        }
        
    }
}


//MARK:- UICollectionViewDataSource

extension KLRecommendSycleView : UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.rModelsArr?.count ?? 0) * 10000
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
 
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! KLCycleCollectionCell
        
//        cell.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g:CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
        
        
        cell.rCycleModel =  self.rModelsArr![indexPath.item % rModelsArr!.count]
        
 
        return cell
        
    }
    
    
}

extension KLRecommendSycleView : UICollectionViewDelegate{
    
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//
//
//        print("停止滚动了")
//
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//
//        if decelerate == false{
//            scrollViewDidEndDecelerating(scrollView)
//        }
//    }
//
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        
        rPageControl.currentPage = Int(offX/kScreenW) % (rModelsArr?.count ?? 1)

        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       
        
     
        removeTimer()
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       
      
        addTimer()
    }
    
}

extension KLRecommendSycleView {
    
     func addTimer() {
        
        guard rTimer == nil else {
                  return
              }
        
        if #available(iOS 10.0, *) {
            rTimer = Timer(timeInterval: 3.0, repeats: true, block: { (timer) in
                 self.scrolToNext()
            })
        } else {
            // Fallback on earlier versions
            
            
            
            rTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrolToNext), userInfo: nil, repeats: true)
        }
         RunLoop.current.add(rTimer!, forMode: .common)

    }
    
    
    func removeTimer()  {
        
        
        guard rTimer != nil else {
                        return
                    }
        
        rTimer?.invalidate()
        
        rTimer = nil
         
    }
    
    @objc func scrolToNext () {
        
 
        let currentOffx = rCollectionView.contentOffset.x
        
         
        rCollectionView.setContentOffset(CGPoint(x: currentOffx + kScreenW, y: 0), animated: true)
    }
}
