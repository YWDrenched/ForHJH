//
//  SelectView.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/6/11.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit

protocol SelectViewDelegate:PortDelegate {
    func selectViewBtnClickWithTag(sender:UIButton)
}

class SelectView: UIView {

    var btn = UIButton()
    var selectPage:Int = 0{
        didSet{
            if selectPage == 0 {
                self.btnClick(sender: pictureBtn)
            }else{
                self.btnClick(sender: commentBtn)
            }
        }
    }
    
    @IBOutlet weak var pictureBtn: UIButton!
    @IBOutlet weak var underLineLabel: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    weak var delegate:SelectViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pictureBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        commentBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
    }
    
    
    
    @objc func btnClick(sender:UIButton) {
        btn.isSelected = false
        sender.isSelected = true
        btn = sender
        UIView.animate(withDuration: 0.3) {
            self.underLineLabel.frame.origin.x = sender.frame.origin.x
        }
        print(sender.tag)
        if delegate != nil {
            delegate?.selectViewBtnClickWithTag(sender:sender)
        }
    }
}
