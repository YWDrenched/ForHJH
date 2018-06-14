//
//  XiaoHuangCell.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/6/14.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit

class XiaoHuangCell: UICollectionViewCell {
    
    var conImageView:UIImageView?
    var img:UIImage!{
        didSet{
            conImageView?.image = img
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    func setupUI(){
        conImageView = UIImageView(frame:bounds)
        addSubview(conImageView!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
