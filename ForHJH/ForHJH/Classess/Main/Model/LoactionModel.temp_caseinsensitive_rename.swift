//
//  loactionModel.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/6/1.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit

class LoactionModel: NSObject {
    
    var latitude:String?
    
    var longitude:String?
    
    
    init(arr:NSArray) {
        super.init()
        for dict in arr {
            setValuesForKeys(dict as! [String : Any])
        }
    }
    
    func loadData()-> NSArray{
        guard let path = Bundle.main.path(forResource: "locationData", ofType: "plist"),
            let arr = NSArray(contentsOfFile: path)else{
                return []
        }
        return arr
    }

    
    override func value(forUndefinedKey key: String) -> Any? {
        return nil
    }
}
