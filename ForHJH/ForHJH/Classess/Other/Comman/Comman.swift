//
//  Comman.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/5/31.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit


/// 屏幕
let kScreenBounds = UIScreen.main.bounds

/// 屏幕宽
let kScreenWidth = UIScreen.main.bounds.width

/// 屏幕高
let kScreenHeight = UIScreen.main.bounds.height

/// 手机版本
let kCurrentVersion = UIDevice.current.systemVersion

///返回一个颜色
func kRandomColor(r:Float , g:Float , b:Float) -> UIColor {
    return UIColor.init(red: (CGFloat(r/255.0)), green: (CGFloat(r/255.0)), blue: (CGFloat(r/255.0)), alpha: 1.0)
}
/// 导航栏高度
let kNavHeight:Int = 64
let kTabbarHeight:Int = 49

extension Bundle{
    func namespace() -> String {
        return Bundle.main.infoDictionary?["CFBundleName"]  as? String ?? ""
    }
}




