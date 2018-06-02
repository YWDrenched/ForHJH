//
//  WalkNavButton.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/6/2.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit


private class WalkNavButton: UIButton {
    
    var walklabel = UILabel()
    var walkImg = UIImageView(image:UIImage(named: "步行"))
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        setBackgroundImage(UIImage(named:"naviBackgroundNormal"), for: .normal)
        setBackgroundImage(UIImage(named:"naviBackgroundHighlighted"), for: .highlighted)
        
        walklabel.text = "导航"
        walklabel.font = UIFont.systemFont(ofSize: 10)
        walklabel.textColor = UIColor.white
        addSubview(walklabel)
        
        walkImg.sizeToFit()
        addSubview(walkImg)
        
        walkImg.snp.makeConstraints { (make)->Void in
            make.centerY.equalTo(self).offset(-13)
            make.centerX.equalTo(self)
        }
        walklabel.snp.makeConstraints { (make)->Void in
            make.top.equalTo(walkImg.snp.bottom)
            make.centerX.equalTo(self)
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        walkImg.center = CGPoint(x: frame.midX, y: (superview?.frame.midY)! - walkImg.frame.height * (0.5 + 0.1))
//        walklabel.center = CGPoint(x: frame.midX, y: (superview?.frame.midY)! + walkImg.frame.height * (0.5 + 0.1))
//
//    }
}



typealias blockClosure = () ->Void
class CYW_AnnotationView: MAAnnotationView {
    
    var didClickItemBlock:blockClosure?
    
    override init!(annotation: MAAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let walkBtn = WalkNavButton(frame: CGRect(x: 0, y: 0, width: 44, height: 70))
        
        walkBtn.addTarget(self, action: #selector(walkBtnClick), for: .touchUpInside)
        leftCalloutAccessoryView = walkBtn
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func walkBtnClick() {
        if didClickItemBlock != nil {
            didClickItemBlock!()
        }
    }
}
