//
//  KLHomeController.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/28.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLHomeController: KLBaseViewController {
    
    
    //MARK:懒加载属性
    
    private lazy var rPageTitleView : KLPageTitleView = { [weak self] in
        
        let titleView = KLPageTitleView.init(frame: CGRect(x: 0, y: 0, width:kScreenW , height: 40), titles: ["推荐","游戏","娱乐","趣玩"])
        titleView.backgroundColor = .white
        titleView.delegate = self
        return titleView
    }()
    
    
    lazy var rPageContentView : KLPageContentView = { [weak self] in
        
//        let contentFrame = CGRect(x: 0, y: kStatusBaarH + kNavigationBarH + 40, width: kScreenW, height: (self?.view.frame.height)! - 40 - 10)
        
        
        let contentFrame = CGRect(x: 0, y:   40, width: kScreenW, height: (self?.view.frame.height)! - 40  - kTabbarH - kStatusBaarH - kNavigationBarH)

        var childs = [UIViewController]()
        childs.append(KLRecommendController())
        childs.append(KLGameViewController())
        
        childs.append(KLAmuseViewController())
        
        childs.append(KLFunnyViewController())

        
 
         let contentView = KLPageContentView.init(frame: contentFrame, childVCs: childs, parentController:self)
        contentView.delegate = self
        return contentView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "首页"
        
        UINavigationController.initializeMethod()
        edgesForExtendedLayout =  []
        setupUI()
        
        
     }
    
    
  
}



//MARK:- 设置UI界面
extension KLHomeController{
    
    
    private func setupUI( )   {
        setNavigationBar()
        //添加titleview
        view.addSubview(rPageTitleView)
        //添加content
        view.addSubview(rPageContentView)
    }
    
    //设置导航
    func setNavigationBar() {
        
        //设置左边按钮
        let logBtn = UIBarButtonItem.init(imageName: "logo", highImageName: "", size: .zero)
        navigationItem.leftBarButtonItem = logBtn
        
        let size = CGSize(width: 40, height: 40)
        
        let qrcodeBtn = UIBarButtonItem.init(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        let searchBtn = UIBarButtonItem.createItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        let historyBtn = UIBarButtonItem.createItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyBtn,searchBtn,qrcodeBtn]
        
    }
    
    
}


//MARK:- PageTitleViewDelegate协议
extension KLHomeController : PageTitleViewDelegate{
    func pageTitleView(titleView: KLPageTitleView, selectIndex: Int) {
         
         rPageContentView.setCurrentIndex(index: selectIndex)
    }
    
    
    
}

 
//MARK:- PageContentViewDelegate协议
extension KLHomeController : PageContentViewDelegate {
    func PageContentView(contentView: KLPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
         
        
        rPageTitleView.setTitleWithProgress(progress: progress, sourceIdex: sourceIndex, targetIndex: targetIndex)
    }
    
   
    
}

 
