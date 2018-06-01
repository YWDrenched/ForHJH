//
//  HomeViewController.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/5/31.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit
import YYModel


class HomeViewController: BaseViewController,MAMapViewDelegate,AMapLocationManagerDelegate{
    
    var mapView:MAMapView!
    var locationManager :AMapLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupLocationManager()
        setupMapView()
        setupUI()
//        let arr = NSArray.yy_modelArray(with: LocationModel.self, json: loadData() )
//        print(arr)
        for dict in loadData() {
            print(dict)
        }
       
        
    }
    func loadData()-> NSArray{
        guard let path = Bundle.main.path(forResource: "locationData", ofType: ".plist"),
            let arr = NSArray(contentsOfFile: path)else{
                return []
        }
        return arr
    }
    
    func setupUI() {
        mapView.addSubview(locationBtn)
        locationBtn.snp.makeConstraints { (make)->Void in
            make.left.equalTo(mapView).offset(10)
            make.bottom.equalTo(mapView).offset(-60)
//            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }

    func setupMapView() {
        mapView = MAMapView(frame: kScreenBounds)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.zoomLevel = 15
        mapView.userTrackingMode = .followWithHeading
        view.addSubview(mapView)
        
    }
    
    func setupLocationManager(){
        locationManager = AMapLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    lazy var locationBtn: UIButton = {
        var locationBtn = UIButton(title: "", backImg: "ic_location", selImg: "", target: self, action: #selector(locationBtnClick))
//        locationBtn.backgroundColor = UIColor.red
        return locationBtn
    }()
    
    @objc func locationBtnClick() {
        mapView.showsUserLocation = true
        mapView.zoomLevel = 15
        mapView.userTrackingMode = .followWithHeading
    }

}
