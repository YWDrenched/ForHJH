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

extension UIButton{
    
    convenience init(title:String,backColor:UIColor,backImgStr:String,target:Any,selector:Selector) {
        self.init()
        setTitle(title, for: .normal)
        backgroundColor = backColor
        setBackgroundImage(UIImage(named:backImgStr), for: .normal)
        addTarget(target, action: selector, for: .touchUpInside)
    }
}

extension UIColor{
    /// 设置随机颜色
    class func UIColorRandom() -> UIColor
    {
        let color: UIColor = UIColor.init(red: (((CGFloat)((arc4random() % 256)) / 255.0)), green: (((CGFloat)((arc4random() % 256)) / 255.0)), blue: (((CGFloat)((arc4random() % 256)) / 255.0)), alpha: 1.0);
        return color;
    }
    class func UIColorRGB_Alpha(R:CGFloat, G:CGFloat, B:CGFloat, alpha:CGFloat) -> UIColor
    {
        let color = UIColor.init(red: (R / 255.0), green: (G / 255.0), blue: (B / 255.0), alpha: alpha);
        return color;
    }
    /// 设置颜色与透明度 示例：UIColorHEX_Alpha(0x26A7E8, 0.5)
    class func UIColorHex_Alpha(value:UInt32, alpha:CGFloat) -> UIColor
    {
        let color = UIColor.init(red: (((CGFloat)((value & 0xFF0000) >> 16)) / 255.0), green: (((CGFloat)((value & 0xFF0000) >> 16)) / 255.0), blue: (((CGFloat)((value & 0xFF0000) >> 16)) / 255.0), alpha: alpha)
        return color
    }
    /// 设置颜色（RGB：0.0~255.0） 示例：UIColorRGB(100, 100, 100)
    class func UIColorRGB(R:CGFloat, G:CGFloat, B:CGFloat) -> UIColor
    {
        return UIColorRGB_Alpha(R: R, G: G, B: B, alpha: 1.0);
    }
    
    /// 设置颜色 示例：UIColorHex(0x26A7E8)
    class func UIColorHex(value:UInt32) -> UIColor
    {
        return UIColorHex_Alpha(value: value, alpha: 1.0);
    }
}




