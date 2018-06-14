//
//  CommentsView.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/6/13.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit

protocol CommentsViewDelegate:PortDelegate {
    func commentViewComfirmBtnClick(comments:String?);
}

class CommentsView: UIView{
    
    weak var delegate:CommentsViewDelegate?

    @IBOutlet weak var commentsField: UITextField!
    
    @IBOutlet weak var comfirmBtn: UIButton!
    
    @IBOutlet weak var closeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        comfirmBtn.addTarget(self, action: #selector(comfirmBtnClick), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
    }
    
    @objc func comfirmBtnClick(){
        if delegate != nil {
            delegate?.commentViewComfirmBtnClick(comments: commentsField.text)
        }
    }
    
    @objc func closeBtnClick(){
        isHidden = true
        endEditing(true)
    }
    
}
