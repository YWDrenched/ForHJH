//
//  BaseTableViewController.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/5/31.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit


class BaseTableViewController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTabbarData()
       
    }
    
    private func loadTabbarData(){
        let arr = [
            ["title": "要吃","img":"tab_icon_friend","vc":"FavoriteViewController"],
            ["title": "要去","img":"tab_icon_mobile_store","vc":"HomeViewController"],
            ["title": "要吃","img":"tab_icon_news","vc":"ProfileViewController"]
        ]
        var arrM = [UIViewController]()
        for dict in arr {
            let vc = setupTabbarVC(dict: dict)
            arrM.append(vc)
        }
        viewControllers = arrM
    }
    
    
    private func setupTabbarVC(dict:[String:String])->UIViewController{
        
        guard let til = dict["title"],
            let imgStr = dict["img"],
            let clsName = dict["vc"],
            let cls = NSClassFromString(Bundle.main.namespace()+"."+clsName) as? BaseViewController.Type
            else {
            return UIViewController()
        }
        let vc = cls.init()
        vc.title = til
        vc.tabBarItem.image = UIImage(named:imgStr+"_normal")
        vc.tabBarItem.selectedImage = UIImage(named:imgStr+"_press")
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.brown], for: .selected)
        let navVC = BaseNavController(rootViewController: vc)
        return navVC
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
