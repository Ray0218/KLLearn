//
//  KLGameCollectionCell.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/1.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLGameCollectionCell: UICollectionViewCell {
    
    
    lazy var rImageView : UIImageView = {
        
        let imageV = UIImageView()
        imageV.layer.cornerRadius = 22.5
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    lazy var rTitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var  rAnchGroup : KLBaseGameModel?{
        
        didSet {
            
             rTitleLabel.text = rAnchGroup?.tag_name
            
            let urls = URL(string: rAnchGroup?.icon_url ?? "")
            
            rImageView.kf.setImage(with:urls,placeholder: UIImage(named: "home_more_btn"))
 
         }
    }
    
}


extension KLGameCollectionCell {
    
    func setupUI ()  {
        contentView.addSubview(rImageView)
        contentView.addSubview(rTitleLabel)
        
        rImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(45)
            make.top.equalToSuperview().offset(15)
            
        }
        
        rTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
}
