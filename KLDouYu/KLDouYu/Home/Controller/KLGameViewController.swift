//
//  KLGameViewController.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/2.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

private let kGamesCellId = "kGamesCellId"

private let kGameHeaderReuseId = "kGameHeaderReuseId"

private let kEdgeMargin : CGFloat = 10

private let kItemW : CGFloat = (kScreenW - 2*kEdgeMargin)/3

private let kItemH : CGFloat = kItemW*6/5

class KLGameViewController: KLHomeBaseController {
    
    
    //MARK:懒加载
    lazy var rCollectionView : UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0 //行间距
                  layout.headerReferenceSize = CGSize(width: kScreenW, height: 50)
        
        //          layout.sectionInset = UIEdgeInsets.init(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectioview = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        //          collectioview.delegate = self
        collectioview.dataSource = self
        
        
        collectioview.register(KLGameCollectionCell.self, forCellWithReuseIdentifier: kGamesCellId)
        
                  collectioview.register(KLRecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kGameHeaderReuseId)
        collectioview.backgroundColor = .white
        
        collectioview.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        collectioview.contentInset = UIEdgeInsets(top:kGameViewH + 50, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        return collectioview
        }()
    
    lazy var rGameHeaderView : KLRecommendHeaderView = {
        
        let header = KLRecommendHeaderView()
        header.rTitleLabel.text = "常见"
        header.rImageView.image = UIImage(named: "Img_orange")
        header.rMoreButton.isHidden = true
        header.frame = CGRect(x: 0, y: -kGameViewH-50, width: kScreenW, height: 50)
        
        return header
    }()
    
  private  lazy var rViewModel : KLGameViewModel  = KLGameViewModel()
    
        lazy var rGameView : KLRecommendGameView  = {
    
    
               let sycleView = KLRecommendGameView(frame: CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH))
    
               return sycleView
    
           }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        loadData()
        
    }
    
    
    override func setupUI() {
        
        view.addSubview(rCollectionView)
        self.rCollectionView.addSubview(rGameHeaderView)

        rCollectionView.addSubview(rGameView)
        
        rContentView = rCollectionView
        
        super.setupUI()
         
    }
    
    
    
}




//MARK:- 请求数据
extension KLGameViewController {
    
    func loadData ()  {
        
        self.rViewModel.requestData {
            self.rCollectionView.reloadData()
            
            let temp = self.rViewModel.rGames[0..<10]
                   
            self.rGameView.rAnchGroups = Array(temp)
            
            self.loadDataFinish()

        }
        
        
       
        
    }
    
    
}

 

extension KLGameViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rViewModel.rGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGamesCellId, for: indexPath) as! KLGameCollectionCell
        
        cell.rAnchGroup = self.rViewModel.rGames[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           
           
           let header =   collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: kGameHeaderReuseId, for: indexPath) as! KLRecommendHeaderView
           
 
        header.rTitleLabel.text = "全部"
        header.rImageView.image = UIImage(named: "Img_orange")
        
        header.rMoreButton.isHidden = true
           
           return header
           
       }
       
    
    
}
