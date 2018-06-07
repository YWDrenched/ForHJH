//
//  ProfileViewController.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/5/31.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var dataArr = [TestModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        loadData()
    }
    
    func loadData(){
        CYWNetWorkManager.sharedManger.requset(requestMethon: .GET, URLString: "http://live.9158.com/Room/GetNewRoomOnline?page=1", params: nil) { (result, error) in
//            if error {
//                print("网络连接失败")
//                return
//            }
//            print(result)
            
            guard let msg = result as? [String:Any],
                let data = msg["data"] as? [String:Any],
                let list = data["list"],
                let arr = NSArray.yy_modelArray(with: TestModel.self, json: list) as? [TestModel] else{
                return
            }
            self.dataArr = arr
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCellID") as? TestCell
        cell?.model = dataArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: kScreenBounds)
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "TestCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "testCellID")
        return tableView
    }()
    

}
