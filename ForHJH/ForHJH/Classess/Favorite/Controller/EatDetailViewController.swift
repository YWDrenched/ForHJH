//
//  EatDetailViewController.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/6/11.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit
import SDPhotoBrowser
import JXPhotoBrowser


class EatDetailViewController: UIViewController,SelectViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CommentsViewDelegate,PhotoBrowserDelegate {
    
    
   
    
   
    var index:IndexPath?
    var flag:Int = 0
    var picture:UIImage?
    var arr=[UIImage]()
    var model:LocationModel!
   
    
   
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func photoBrowser(_ photoBrowser: PhotoBrowser, thumbnailViewForIndex index: Int) -> UIView? {
        return collectionView.cellForItem(at: IndexPath(item: index, section: 0))
    }
    
    func photoBrowser(_ photoBrowser: PhotoBrowser, thumbnailImageForIndex index: Int) -> UIImage? {
        let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! XiaoHuangCell

        
        
        return cell.img
    }
    
    func numberOfPhotos(in photoBrowser: PhotoBrowser) -> Int {
        return imgs.count
    }
    
    @objc func keyboardWillShow(note:Notification) {
        UIView.animate(withDuration: 0.3) {
            self.commentsView.transform = CGAffineTransform(translationX: 0, y: -40)
        }
    }
    
    @objc func keyboardWillHide(note:Notification) {
        UIView.animate(withDuration: 0.3) {
            self.commentsView.transform = CGAffineTransform(translationX: 0, y: 40)
        }
    }
   
    func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(typeView)
        view.addSubview(selectView)
        typeView.addSubview(collectionView)
        typeView.addSubview(tableView)
        view.addSubview(addBtn)
        view.addSubview(commentsView)
        
        addBtn.snp.makeConstraints { (make)->Void in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-10)
        }
        commentsView.snp.makeConstraints { (make)->Void in
            make.center.equalTo(view)
            make.left.equalTo(view).offset(20)
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
            self.commentsView.isHidden = false
        }
    }
    
    //    MARK:imagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        guard let imgStr = UIImageJPEGRepresentation(image, 0.1)?.base64EncodedString()
            else{
                return
            }
    
        let path = NSHomeDirectory() + "/Documents/\(model.subTitle ?? "").plist"
        imgs.add(imgStr)
        imgs.write(toFile: path, atomically: true)

        picker.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
//    MARK:selectViewDelegate
    func selectViewBtnClickWithTag(sender:UIButton) {
        let page = sender.tag - 1000
        typeView.setContentOffset(CGPoint(x: page * Int(typeView.bounds.width), y: 0), animated: true)
        flag = Int(page)
        page == 0 ? (addBtn.setTitle("点击添加照骗", for: .normal)):addBtn.setTitle("点击添加评论", for: .normal)
    }
    
//    MARK:commentsViewDelegate
    func commentViewComfirmBtnClick(comments: String?) {
        commentsArr.add(comments ?? "")
        let path = NSHomeDirectory() + "/Documents/\(model.subTitle ?? "")"+"Coments.plist"
        commentsArr.write(toFile: path, atomically: true)
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.commentsView.isHidden = true
            self.view.endEditing(true)
        }
    }
//    MARK:scrollerVierDelegate
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
        return imgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewID", for: indexPath) as! XiaoHuangCell
        cell.backgroundColor = UIColor.UIColorRandom()
        
        if imgs.count != 0 {
            let img = UIImage(data: Data(base64Encoded: imgs[indexPath.item] as! String )!)
            cell.img = img
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        PhotoBrowser.show(byViewController: self, delegate: self, index: indexPath.item)
    }
    
    
    
//    MARK:tableViewDataSoure
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID", for: indexPath)
        cell.textLabel?.text = commentsArr[indexPath.row] as? String
        cell.selectionStyle = .none
        return cell
    }
    
    
//    MARK:懒加载
    
    
    
    
    lazy var imgs: NSMutableArray = {
        let path = NSHomeDirectory() + "/Documents/\(model.subTitle ?? "").plist"
        guard var imgs = NSMutableArray(contentsOfFile: path)
            else{
                return NSMutableArray()
        }
        return imgs
    }()
    
    lazy var commentsArr:NSMutableArray = {
        let path = NSHomeDirectory() + "/Documents/\(model.subTitle ?? "")"+"Coments.plist"
        guard var commentsArr = NSMutableArray(contentsOfFile: path)
            else{
                return NSMutableArray()
        }
        return commentsArr
    }()
    
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
        collectionView.register(XiaoHuangCell.self, forCellWithReuseIdentifier: "collectionViewID")
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
    
    lazy var commentsView: CommentsView = {
        var commentsView = Bundle.main.loadNibNamed("CommentsView", owner: nil, options: nil)?.last as! CommentsView
//        commentsView.frame = view.bounds
        commentsView.delegate = self
        commentsView.isHidden = true
        return commentsView
    }()
    
}
