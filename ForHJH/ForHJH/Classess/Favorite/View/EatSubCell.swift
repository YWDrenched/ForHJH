//
//  EatSubCell.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/6/5.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit

class EatSubCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var model:LocationModel?{
        didSet{
            titleLabel.text = model?.title
            picture.image = UIImage(named:(model?.img)!)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        // Configure the view for the selected state
    }

}
