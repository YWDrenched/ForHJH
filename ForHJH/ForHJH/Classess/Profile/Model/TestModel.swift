//
//  TestModel.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/6/7.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit

class TestModel: NSObject {
    
    /// 总人数
    @objc var allnum:Int = 0
    
    @objc var anchorLevel:Int = 0
    
    /// 是否为新星
    @objc var new:Int = 0
    
    /// 房间号
    @objc var roomid:Int = 0
    
    /// 等级
    @objc var starlevel:Int = 0
    
    /// 家族名称
    @objc var familyName:String?
    
    /// 地点
    @objc var position:String?
    
    /// 照片
    @objc var photo:String?
    
    /// 别名
    @objc var nickname:String?

}
