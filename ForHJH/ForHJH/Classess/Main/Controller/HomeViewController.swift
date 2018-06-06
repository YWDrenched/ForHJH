//
//  HomeViewController.swift
//  ForHJH
//
//  Created by 陈友文 on 2018/5/31.
//  Copyright © 2018年 陈友文. All rights reserved.
//

import UIKit
import YYModel


class HomeViewController: BaseViewController,MAMapViewDelegate,AMapLocationManagerDelegate,AMapNaviWalkManagerDelegate{
    
    var mapView:MAMapView!
    var locationManager :AMapLocationManager!
    var locations = [LocationModel]()
    var annotations = [MAPointAnnotation]()
    var walkManager : AMapNaviWalkManager!
    var endPoint : AMapNaviPoint?
    var startPoint : AMapNaviPoint?

   


    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupLocationManager()
        setupMapView()
        setupUI()
        loadData()
        initNav()
    }
    
    //    MARK:加载本地数据
    func loadData() -> (){
        guard let path = Bundle.main.path(forResource: "locationData", ofType: ".plist"),
            let arr = NSArray(contentsOfFile: path) as? [[String:String]] else{
                print("加载错误")
                return
        }
        for dict in arr {
            let model = LocationModel(dict: dict)
            self.locations.append(model)
            let annotation = MAPointAnnotation()
            annotation.title = model.title ?? ""
            annotation.subtitle = model.subTitle ?? ""
            var coordinate = CLLocationCoordinate2D()
            coordinate.latitude = Double(model.latitude ?? "")!
            coordinate.longitude = Double(model.longitude ?? "")!
            annotation.coordinate = coordinate
            self.annotations.append(annotation)
        }
        DispatchQueue.main.async {
            self.mapView.addAnnotations(self.annotations)
        }
    }
    
    
    func walkManager(onCalculateRouteSuccess walkManager: AMapNaviWalkManager) {
        NSLog("CalculateRouteSuccess")
        
        //算路成功后显示路径
        showNaviRoutes()
    }
    
    //MARK:mapView代理
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKind(of: MAUserLocation.self) {
            return nil
        }
        let annotionID = "annotionID"
        var mapAnnotionView = mapView.dequeueReusableAnnotationView(withIdentifier: annotionID) as? CYW_AnnotationView
        if mapAnnotionView == nil{
            mapAnnotionView = CYW_AnnotationView(annotation: annotation, reuseIdentifier: annotionID)
        }
        mapAnnotionView?.image = UIImage(named:"定位针")
        mapAnnotionView?.canShowCallout = true
        mapAnnotionView?.isDraggable = false
        mapAnnotionView?.didClickItemBlock = {
            self.walkManager.calculateWalkRoute(withStart: [self.startPoint!], end: [self.endPoint!])
        }
//        mapAnnotionView.animatesDrop = false
        return mapAnnotionView
    }
//    点击气泡回调
    func mapView(_ mapView: MAMapView!, didAnnotationViewCalloutTapped view: MAAnnotationView!) {
        print("点击了气泡")

    }
    //点击annotation回调
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        print(1)
        if view.annotation is MAPointAnnotation{
            let annotation = view.annotation as! MAPointAnnotation
            
            endPoint = AMapNaviPoint.location(withLatitude:CGFloat(annotation.coordinate.latitude), longitude: CGFloat(annotation.coordinate.longitude))
            startPoint = AMapNaviPoint.location(withLatitude: CGFloat(self.mapView.userLocation.coordinate.latitude), longitude: CGFloat(self.mapView.userLocation.coordinate.longitude))
        }
    }
    
    
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if overlay.isKind(of: MAPolyline.self) {
            let renderer: MAPolylineRenderer = MAPolylineRenderer(overlay: overlay)
            renderer.lineWidth = 8.0
            renderer.strokeColor = UIColor.cyan
            
            return renderer
        }
        return nil
    }
    
    //MARK:显示地图路径
    func showNaviRoutes() {
        guard let aRoute = walkManager.naviRoute else {
            return
        }
        mapView.removeOverlays(mapView.overlays)

        //将路径显示到地图上
        var coords = [CLLocationCoordinate2D]()
        for coordinate in aRoute.routeCoordinates {
            coords.append(CLLocationCoordinate2D.init(latitude: Double(coordinate.latitude), longitude: Double(coordinate.longitude)))
        }
        //添加路径Polyline
        let polyline = MAPolyline(coordinates: &coords, count: UInt(aRoute.routeCoordinates.count))!
        mapView.add(polyline)

        
       
    }
    
//    MARK:初始化
    
    func setupUI() {
        mapView.addSubview(locationBtn)
        locationBtn.snp.makeConstraints { (make)->Void in
            make.left.equalTo(mapView).offset(10)
            make.bottom.equalTo(mapView).offset(-60)

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
    
    func initNav(){
        walkManager = AMapNaviWalkManager()
        walkManager.delegate = self
        
    }
    
    lazy var locationBtn: UIButton = {
        var locationBtn = UIButton(title: "", backImg: "ic_location", selImg: "", target: self, action: #selector(locationBtnClick))
        return locationBtn
    }()
    
    @objc func locationBtnClick() {
        mapView.showsUserLocation = true
        mapView.zoomLevel = 15
        mapView.userTrackingMode = .followWithHeading
    }

}
