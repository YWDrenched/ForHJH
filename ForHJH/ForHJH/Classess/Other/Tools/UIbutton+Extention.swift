//
//  UIbutton+Extention.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/5/31.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit

extension UIButton{
    convenience init(title:String,backImg:String,selImg:String,target:Any?,action:Selector) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setBackgroundImage(UIImage.init(named: backImg), for: .normal)
        self.setBackgroundImage(UIImage.init(named: selImg), for: .highlighted)
        self.addTarget(target, action: action, for: .touchUpInside)
        
        self.sizeToFit()
    }
}
