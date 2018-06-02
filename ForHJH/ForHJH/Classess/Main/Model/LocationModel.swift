//
//  loactionModel.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/6/1.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit

class LocationModel: NSObject {
    
    @objc var latitude:String?
    
    @objc var longitude:String?
    
    @objc var title:String?
    
    @objc var subTitle:String?
 
    
    init(dict:[String:String]) {
        super.init()
        setValuesForKeys(dict)
    }

   
    override var description: String{
        return "la:\(String(describing: latitude))\n long:\(String(describing:longitude))"
    }
    
    override func value(forUndefinedKey key: String) -> Any? {
        return key
    }
    
    
}
