//
//  KLNormalCollectionCell.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/31.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLNormalCollectionCell: UICollectionViewCell {
    
    lazy var rImageView : UIImageView = {
        
        let imageV = UIImageView(image: UIImage(named: "Img_default"))
//        imageV.backgroundColor = .orange
        imageV.layer.cornerRadius = 5.0
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    
    lazy var rNameLabel : UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 11)
        label.text = "草莓"
        
        return label
    }()
    
    
    lazy var rOnlineBtn : UIButton = {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: "Image_online"), for: .normal)
        btn.setTitle("666", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 11)
        
        return btn
    }()
    
    lazy var rPlayImg : UIImageView  = {
        let img = UIImageView(image: UIImage(named: "home_live_cate_normal"))
        return img
    }()
    
    lazy var rTitleLabel : UILabel = {
        
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.text = "颜值"
        
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var  rAnchor : KLAnchorModel?{
        
        
        didSet{
            
            rNameLabel.text = rAnchor?.nickname
            rTitleLabel.text = rAnchor?.room_name
             
            
            rOnlineBtn.setTitle(rAnchor?.rOnline, for: .normal)
//            rImageView.kf.setImage(with: URL(string: rAnchor?.vertical_src ?? ""), placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
//
//            }
            
            
            guard let uconUrl = rAnchor?.vertical_src else {
                rImageView.image = UIImage(named: "Img_default")

                return
            }
            
            rImageView.kf.setImage(with: URL(string: uconUrl),placeholder: UIImage(named: "Img_default"))
 
        }
    }
    
}


extension KLNormalCollectionCell {
    
    func  setupUI() {
        
        contentView.addSubview(rImageView)
        contentView.addSubview(rNameLabel)
        contentView.addSubview(rOnlineBtn)
        
        contentView.addSubview(rPlayImg)
        contentView.addSubview(rTitleLabel)
        
        rImageView.snp.makeConstraints { (make) in
            make.left.top.width.equalToSuperview()
            make.bottom.equalTo(rTitleLabel.snp_top).offset(-5)
        }
        
        
        rNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(rImageView).offset(5)
            make.bottom.equalTo(rImageView).offset(-5)
        }
        
        
        rOnlineBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(rNameLabel)
            make.right.equalTo(rImageView).offset(-5)
        }
        
        
        rPlayImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.size.equalTo(14)
            make.centerY.equalTo(rTitleLabel)
        }
        
        
        rTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(rPlayImg.snp_right).offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(15)
            make.right.equalToSuperview()
        }
        
        
    }
}
