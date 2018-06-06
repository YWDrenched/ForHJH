//
//  EatCell.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/6/5.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit

class EatCell: UITableViewCell {
    
    var model:LocationModel?{
        didSet{
            mainTitle.text = model?.title
        }
    }
    
    @IBOutlet weak var mainTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
