//
//  KLPageTitleView.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/29.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

//class 表示当前协议只能被类遵守
protocol PageTitleViewDelegate : class  {
    
    func pageTitleView(titleView: KLPageTitleView, selectIndex : Int)
     
}


//MARK:- 定义常量
let kScrollLineH : CGFloat = 2.0

let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)



class KLPageTitleView: UIView {
    
     //MARK:定义属性
    private var rTites : [String]
    
    private var rCurrentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    
    
    //MARK: 懒加载属性
    lazy var rTitleLabels : [UILabel] = [UILabel]()
    
    private lazy var rScrollView : UIScrollView = {
        
        let scroll = UIScrollView()
        
        scroll.showsHorizontalScrollIndicator = false
        scroll.scrollsToTop = false
        scroll.bounces = false
        
        return scroll
        
    }()
    
    
    lazy var rScrollLine : UIView = {
         let scrolLine = UIView()
        scrolLine.backgroundColor = .orange
        
        return scrolLine
     }()
    
    //MARK: 自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.rTites = titles
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//MARK:- 设置UI界面

extension KLPageTitleView{
    
    private func setupUI ()  {
        
        if #available(iOS 13.0, *) {
            rScrollView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            // Fallback on earlier versions
        }
        
        addSubview(rScrollView)
        rScrollView.frame = bounds
        //添加titile
        
        setupTitleLabels()
        
        setupBottomMenueAndLine()
    }
    
    private func setupTitleLabels()  {
 
        let labelW : CGFloat = frame.width / CGFloat(rTites.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index,title) in rTites.enumerated() {
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textAlignment = .center
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            
            
            let labelX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            rScrollView.addSubview(label)
            rTitleLabels.append(label)
            label.isUserInteractionEnabled = true
            
            //给label添加手势
            
            let rTapGes = UITapGestureRecognizer(target: self, action: #selector(pvt_titleLabel(tapGes:)))
            
            label.addGestureRecognizer(rTapGes)
        }
        
    }
    
    
    
    
    func setupBottomMenueAndLine()  {
   
        //底部分割线
        let  bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - 0.5, width: frame.width, height: 0.5)
        addSubview(bottomLine)
        
        //滚动线
         rScrollView.addSubview(rScrollLine)
        
        //获取第一个label
        guard let firstLabel = rTitleLabels.first else {
            return
        }
        
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        //设置滚动线的属性
        rScrollLine.frame = CGRect(origin: CGPoint(x: firstLabel.frame.origin.x, y: frame.size.height - kScrollLineH), size: CGSize(width: firstLabel.frame.width, height:kScrollLineH))
        
 
    }
}



//MARK:- 监听Label的点击事件
extension KLPageTitleView{
    
    
    @objc private func pvt_titleLabel(tapGes: UITapGestureRecognizer)  {
         
         //获取当前label的下标
        
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        
        if currentLabel.tag == rCurrentIndex {
            return
        }
        
        //获取之前的label
        let oldLabel = rTitleLabels[rCurrentIndex]
        oldLabel.textColor =  UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
       
        //保留最新下标
        rCurrentIndex = currentLabel.tag
        
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        
        let rCenter = CGPoint(x: currentLabel.center.x, y: rScrollLine.center.y)
        
        rScrollLine.center = rCenter
        
        delegate?.pageTitleView(titleView: self, selectIndex: rCurrentIndex)
    }
}


//MARK:- 对外暴露方法
extension KLPageTitleView {
    
    func  setTitleWithProgress(progress: CGFloat, sourceIdex: Int , targetIndex : Int)  {
        
        //取出元lable和目标label
        let sourceLabel = rTitleLabels[sourceIdex]
        let targetLabel = rTitleLabels[targetIndex]
        
        //处理滑块逻辑
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        
        rScrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
 
        //颜色的渐变
        
        //取出渐变范围
        let colorDue = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - progress * colorDue.0, g: kSelectColor.1 - progress * colorDue.1, b: kSelectColor.2 - progress * colorDue.2)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + progress * colorDue.0, g: kNormalColor.1 + progress * colorDue.1, b: kNormalColor.2 + progress * colorDue.2)

         rCurrentIndex = targetIndex
    }
    
}
