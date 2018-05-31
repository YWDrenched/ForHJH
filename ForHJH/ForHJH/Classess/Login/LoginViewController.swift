//
//  LoginViewController.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/5/31.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI(){
        view.addSubview(logImg)
        logImg.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make)-> Void in
            make.bottom.equalTo(view).offset(-50)
            make.centerX.equalTo(view)
        }
        
    }

    lazy var loginBtn: UIButton = {
        var loginBtn = UIButton(title: "登   录", backImg: "login_button", selImg:"login_button_pressed",target: self, action: #selector(hahah))
        return loginBtn
    }()
    
    lazy var logImg: UIImageView = {
        var logImg = UIImageView(image: UIImage(named: "login_bkg"))
        logImg.isUserInteractionEnabled = true
        logImg.frame = view.bounds
        return logImg
    }()
    
    @objc private func hahah() {
        print("2");
    }
}
