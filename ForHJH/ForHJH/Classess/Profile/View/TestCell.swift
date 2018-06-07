//
//  TestCell.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/6/7.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit
import Kingfisher

class TestCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var LeavlImage: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var pictureImage: UIImageView!
    
    
    
    var model:TestModel?{
        didSet{
            nameLabel.text = model?.nickname
            iconImage.kf.setImage(with:URL(string: model?.photo ?? ""))
            countLabel.text = String(describing: model?.allnum)
            locationLabel.text = model?.position
            pictureImage.kf.setImage(with:URL(string: model?.photo ?? ""))
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        iconImage.layer.cornerRadius = iconImage.bounds.size.width / 2
        iconImage.clipsToBounds = true
    }

//    func initWithTableView(tableView:UITableView)->(TestCell){
//        let cell = tableView.dequeueReusableCell(withIdentifier: "testCellID")
//        if cell == nil{
//            
//        }
//    }
    
}
