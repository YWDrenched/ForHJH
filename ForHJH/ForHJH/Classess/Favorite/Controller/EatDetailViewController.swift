//
//  EatDetailViewController.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/6/11.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit

class EatDetailViewController: UIViewController,SelectViewDelegate,UIScrollViewDelegate {
   
    
    
    var fileManager:FileManager!
    var index:IndexPath?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(typeView)
        view.addSubview(selectView)
    }
    
//    MARK:selectViewDelegate
    func selectViewBtnClickWithTag(sender:UIButton) {
        let page = sender.tag - 1000
        typeView.setContentOffset(CGPoint(x: page * Int(typeView.bounds.width), y: 0), animated: true)
        
    }
    
  
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        UIView.animate(withDuration: 0.3) {
            self.selectView.underLineLabel.frame.origin.x = page * self.selectView.underLineLabel.bounds.size.width
        }
        selectView.selectPage = Int(page)
    }
    
    
    
    lazy var typeView: UIScrollView = {
        let h = Int(kScreenHeight) - kNavHeight - 80 - kTabbarHeight
        var typeView = UIScrollView(frame: CGRect(x: 0, y: 40 + kNavHeight, width: Int(kScreenWidth), height: h))
        typeView.contentSize = CGSize(width: Int(kScreenWidth) * 2, height:h)
        typeView.isPagingEnabled = true
        typeView.backgroundColor = UIColor.red
        typeView.delegate = self
        if #available(iOS 11.0, *) {
            typeView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        };
//        typeView.showsVerticalScrollIndicator = false
//        typeView.showsHorizontalScrollIndicator = false
        return typeView
    }()
    lazy var selectView: SelectView = {
        var selectView = Bundle.main.loadNibNamed("SelectView", owner: nil, options: nil)?.last as! SelectView
        selectView.frame = CGRect(x: 0, y: kNavHeight, width: Int(kScreenWidth), height: 40)
        selectView.delegate = self
        selectView.selectPage = 0
        return selectView
    }()
    
}
