//
//  ProfileViewController.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/5/31.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let dict = ["userId":"USR1000000011PnicVRp",
//            "type":"CDZ"]
        CYWNetWorkManager.sharedManger.requset(requestMethon: .GET, URLString: "http://live.9158.com/Room/GetNewRoomOnline?page=1", params: nil) { (result, error) in
            print(result ?? "   2222")
            if error {
                return
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
