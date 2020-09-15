//
//  KLHomeBaseController.swift
//  KLDouYu
//
//  Created by WKL on 2020/9/2.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLHomeBaseController: UIViewController {
    
    
    var rContentView : UIView?
    
    lazy var animImagView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
      
    }
    

    func  setupUI(){
        
        rContentView?.isHidden = true
        
        view.addSubview(animImagView)
              animImagView.startAnimating()
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
     }
    
    
    func loadDataFinish ()  {
         
        
        animImagView.stopAnimating()
        
        animImagView.isHidden = true
        rContentView?.isHidden = false
    }
    
}
