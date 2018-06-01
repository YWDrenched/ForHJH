//
//  LoginViewController.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/5/31.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class LoginViewController: BaseViewController {
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    private func setupUI(){
        
        view.addSubview(logImg)
        logImg.addSubview(loginBtn)
        logImg.addSubview(userNameFiled)
        logImg.addSubview(passwordFiled)
        
        
        loginBtn.snp.makeConstraints { (make)-> Void in
            make.bottom.equalTo(view).offset(-50)
            make.centerX.equalTo(view)
        }
        userNameFiled.snp.makeConstraints { (make)->Void in
            make.centerX.equalTo(view)
            make.left.equalTo(view).offset(20)
            make.top.equalTo(view).offset(80)
        }
        passwordFiled.snp.makeConstraints { (make)->Void in
            make.centerX.equalTo(view)
            make.left.equalTo(view).offset(20)
            make.top.equalTo(userNameFiled.snp.bottom).offset(20)
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
    lazy var userNameFiled: UITextField = {
        var userNameFiled = UITextField()
        userNameFiled.placeholder = "输入爱的的号码牌"
        userNameFiled.borderStyle = .roundedRect
        userNameFiled.text = "1"
        return userNameFiled
    }()
    
    lazy var passwordFiled: UITextField = {
        var passwordFiled = UITextField()
        passwordFiled.placeholder = "输入爱的的指令"
        passwordFiled.borderStyle = .roundedRect
        passwordFiled.text = "1"
        return passwordFiled
    }()
    
    @objc private func hahah() {
        if userNameFiled.text != "1" && passwordFiled.text != "1" {
            SVProgressHUD.showError(withStatus: "请输入正确的号码牌")
            return
        }
        modalPresentationStyle = .pageSheet
        present(BaseTableViewController(), animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
