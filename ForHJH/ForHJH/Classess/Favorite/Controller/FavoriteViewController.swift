//
//  FavoriteViewController.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/5/31.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit

class FavoriteViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
//    var dataArr:[LocationModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "ThisCell"
        //        let type = dataArr[indexPath.row].type ?? ""
        //        if type == "1" {
        //            cellID = "ThisCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! EatSubCell
        cell.model = dataArr[indexPath.row]
        return cell
            
//        }
//        else{
//            cellID = "cell2"
//            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! EatCell
//            cell.model = dataArr[indexPath.row]
//            return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 300

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EatDetailViewController()
        vc.index = indexPath
        vc.model = dataArr[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    lazy var dataArr: [LocationModel] = {
        var dataArr = [LocationModel]()
        if let path = Bundle.main.path(forResource: "locationData", ofType: ".plist"),
            let arr = NSArray(contentsOfFile: path){
            for dict in arr{
                let model = LocationModel(dict: dict as! [String : String])
                dataArr.append(model)
            }
        }
        return dataArr
    }()
    
    
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: kScreenBounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EatCell", bundle: nil), forCellReuseIdentifier: "cell2")
        tableView.register(UINib(nibName: "EatSubCell", bundle: nil), forCellReuseIdentifier: "ThisCell")
//        tableView.separatorStyle = .none

        return tableView
    }()
    

}
