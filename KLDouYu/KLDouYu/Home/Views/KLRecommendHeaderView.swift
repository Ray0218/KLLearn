//
//  KLRecommendHeaderView.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/29.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit
//import SnapKit
class KLRecommendHeaderView: UICollectionReusableView {
    
    lazy var rBgView : UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        
        return view ;
    }()
    
    lazy var rImageView : UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "home_header_phone"))
        
        return imageV
    }()
    
    lazy var rTitleLabel : UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 17)
        label.text = "颜值"
        
        return label
    }()
    
    lazy var rMoreButton : UIButton  = {
        let btn = UIButton(type: .custom)
        btn.setTitle("更多 >", for:.normal )
        btn.titleLabel?.font = .systemFont(ofSize: 16)
        btn.setTitleColor(.gray, for: .normal)
        return btn
    }()
    
    
    var rAnchorGroup : KLAnchorGroup?{
    
        didSet{
            rTitleLabel.text = rAnchorGroup?.tag_name
            
            
            
            
//            rImageView.image = UIImage(named: rAnchorGroup?.icon_name ?? "home_header_normal")
            
            
            rImageView.kf.setImage(with: URL(string: rAnchorGroup?.icon_url ?? ""), placeholder:  UIImage(named: rAnchorGroup?.icon_name ?? "home_header_normal"), options: nil, progressBlock: nil, completionHandler: nil)
            
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

extension KLRecommendHeaderView {
    
    
    private  func setupUI() {
        
        self.backgroundColor = UIColor(r: 234, g: 234, b: 234)
        
        
        addSubview(rBgView)
        
        addSubview(rImageView)
        addSubview(rTitleLabel)
        addSubview(rMoreButton)
        
        
        rBgView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().offset(-5)
            make.bottom.right.width.equalToSuperview()
        }
        
        rImageView.snp.makeConstraints { (make) in
            make.size.equalTo(18)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        
        rTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(rImageView.snp_right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        rMoreButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        
    }
}
