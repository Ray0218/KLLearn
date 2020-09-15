//
//  KLPrettyCollectionCell.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/31.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLPrettyCollectionCell: UICollectionViewCell {
    private lazy var rImageView : UIImageView = {
        
        let imageV = UIImageView(image: UIImage(named: "live_cell_default_phone"))
//        imageV.contentMode = .scaleAspectFit
        imageV.layer.cornerRadius = 5.0
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    
    lazy var rNameLabel : UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        label.text = "草莓"
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        
        return label
    }()
    
    
    private lazy var rAddressBtn : UIButton = {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: "ico_location"), for: .normal)
        btn.setTitle("广州市", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 11)
        btn.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        return btn
    }()
    
    
    
    private lazy var rOnlineLabel : UIButton = {
        
        let label = UIButton()
        label.setTitleColor(.white, for: .normal)
        label.titleLabel?.font = .systemFont(ofSize: 11)
        label.setTitle("666", for: .normal)
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.contentEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var  rAnchor : KLAnchorModel? {
        
        didSet{
            
            
            
            rNameLabel.text = rAnchor?.nickname
            rAddressBtn.setTitle(rAnchor?.anchor_city, for: .normal)
            
            rOnlineLabel.setTitle(rAnchor?.rOnline, for: .normal)
            
            rImageView.kf.setImage(with: URL(string: rAnchor?.vertical_src ?? ""), placeholder: UIImage(named: "Img_default"), options: nil, progressBlock: { (receivedSize, totalSize) in
                
            }) { (image, error, cacheType, rul) in
                
            }
            
        }
    }
}

extension KLPrettyCollectionCell {
    
    func  setupUI() {
        
        contentView.addSubview(rImageView)
        contentView.addSubview(rNameLabel)
        contentView.addSubview(rAddressBtn)
        
        contentView.addSubview(rOnlineLabel)
        
        rImageView.snp.makeConstraints { (make) in
            make.left.top.width.equalToSuperview()
            make.bottom.equalTo(rNameLabel.snp_top).offset(-5)
        }
        
        
        
        rOnlineLabel.snp.makeConstraints { (make) in
            make.right.equalTo(rImageView.snp_right).offset(-5)
            make.top.equalTo(rImageView).offset(5)
            
        }
        
        rNameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalTo(rAddressBtn.snp_top).offset(-5)
        }
        
        
        rAddressBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview()
        }
        
        
        
        
        
        
    }
}
