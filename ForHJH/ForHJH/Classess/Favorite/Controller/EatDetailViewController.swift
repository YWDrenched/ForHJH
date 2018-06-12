//
//  EatDetailViewController.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/6/11.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit

class EatDetailViewController: UIViewController,SelectViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
   
    
    
    var fileManager:FileManager!
    var index:IndexPath?
    var flag:Int = 0
    var picture:UIImage?
    var arr=[UIImage]()
    var model:LocationModel!


    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory(rawValue: 13)!, FileManager.SearchPathDomainMask(rawValue: 1), true).last! + "/\(model.subTitle ?? "")"
        print(path)
        fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path) {
            do{
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("创建文件失败")
            }
        }
        setupUI()
    }
    
    
    
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(typeView)
        view.addSubview(selectView)
        typeView.addSubview(collectionView)
        typeView.addSubview(tableView)
        view.addSubview(addBtn)
        
        addBtn.snp.makeConstraints { (make)->Void in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-10)
        }
    }
    
    
    @objc func addBtnClick() {
        if flag == 0 {//照骗
            print(1)
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
            
        }else if flag == 1{//评论
            print(2)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        picture = image
        arr.append(image)
        
        picker.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
//    MARK:selectViewDelegate
    func selectViewBtnClickWithTag(sender:UIButton) {
        let page = sender.tag - 1000
        typeView.setContentOffset(CGPoint(x: page * Int(typeView.bounds.width), y: 0), animated: true)
    }
    
  
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UICollectionView.self) || scrollView.isKind(of: UITableView.self) {
            return
        }
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        UIView.animate(withDuration: 0.3) {
            self.selectView.underLineLabel.frame.origin.x = page * self.selectView.underLineLabel.bounds.size.width
            
        }
        selectView.selectPage = Int(page)
        flag = Int(page)
        page == 0 ? (addBtn.setTitle("点击添加照骗", for: .normal)):addBtn.setTitle("点击添加评论", for: .normal)
    }
    
    
//    MARK:collectionViewDataSoure
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewID", for: indexPath)
        cell.backgroundColor = UIColor.UIColorRandom()
        
        if arr.count != 0 {
            let img = UIImageView(image: arr[indexPath.item])
            img.frame = cell.contentView.bounds
            cell.contentView.addSubview(img)
        }
        
        return cell
    }
    
    
//    MARK:tableViewDataSoure
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID", for: indexPath)
        cell.textLabel?.text = "哇，好好吃\(indexPath.row)"
        return cell
    }
    
    
    lazy var typeView: UIScrollView = {
        let h = Int(kScreenHeight) - kNavHeight - 80 - kTabbarHeight
        var typeView = UIScrollView(frame: CGRect(x: 0, y: 40 + kNavHeight, width: Int(kScreenWidth), height: h))
        typeView.contentSize = CGSize(width: Int(kScreenWidth) * 2, height:h)
        typeView.isPagingEnabled = true
        typeView.backgroundColor = UIColor.red
        typeView.delegate = self
        typeView.bounces = false
        if #available(iOS 11.0, *) {
            typeView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        };
        typeView.showsVerticalScrollIndicator = false
        typeView.showsHorizontalScrollIndicator = false
        return typeView
    }()
    lazy var selectView: SelectView = {
        var selectView = Bundle.main.loadNibNamed("SelectView", owner: nil, options: nil)?.last as! SelectView
        selectView.frame = CGRect(x: 0, y: kNavHeight, width: Int(kScreenWidth), height: 40)
        selectView.delegate = self
        selectView.selectPage = 0
        return selectView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (kScreenWidth / 3) - 5, height: kScreenWidth / 3)
        var collectionView = UICollectionView(frame:CGRect(x: 0, y: 0, width: kScreenWidth, height: typeView.bounds.size.height), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewID")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: CGRect(x: kScreenWidth, y: 0, width: kScreenWidth, height: typeView.bounds.size.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCellID")
        tableView.separatorStyle = .none
//        tableView.bounces = false
        return tableView
    }()
    
    lazy var addBtn: UIButton = {
        var addBtn = UIButton(title: "点击添加照骗", backImg: "addBtn_Nor", selImg: "addBtn_Pre", target: self, action: #selector(addBtnClick))
        addBtn.sizeToFit()
        return addBtn
    }()
 
}
