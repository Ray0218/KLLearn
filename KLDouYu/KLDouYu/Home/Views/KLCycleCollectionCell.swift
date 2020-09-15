//
//  KLCycleCollectionCell.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/1.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLCycleCollectionCell: UICollectionViewCell {
    
    lazy var rImageView : UIImageView = {
 
        let imageV = UIImageView()
 
        return imageV
    }()
    
    lazy var rTitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    lazy var rBgView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(rImageView)
        rImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(rBgView)
        contentView.addSubview(rTitleLabel)
        rTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
        }
        
        rBgView.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.right.bottom.left.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    var rCycleModel : KLCycleModel? {
        didSet{
            
            rTitleLabel.text = rCycleModel?.title
            rImageView.kf.setImage(with: URL(string: rCycleModel?.pic_url ?? ""))
        }
    }
    
}


