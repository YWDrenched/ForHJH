//
//  CYWNetWorkManager.swift
//  CywWeiBo
//
//  Created by 陈友文 on 2017/9/29.
//  Copyright © 2017年 陈友文. All rights reserved.
//

import UIKit
import AFNetworking

enum CYWHttpMethon{
    case GET
    case POST
}

class CYWNetWorkManager: AFHTTPSessionManager {
    
    //MARK: 单例
    static let sharedManger = CYWNetWorkManager()
 
    //MARK:网络请求 post get
    func requset(requestMethon:CYWHttpMethon,URLString:String,params:Any?,completion:@escaping (Any?, Bool) -> ()) {
        let successTask = {(task:URLSessionDataTask,json:Any?)->() in
            completion(json,true)
        }
        
        let failureTask = {(task:URLSessionDataTask?,error:Error)-> () in
            print("网络请求失败:\(error)")
            completion(nil,false)
        }

        if requestMethon == .POST {
         
        post(URLString,
             parameters: params,
             progress: nil,
             success: successTask,
             failure: failureTask)
            
        }else{
            get(URLString,
                parameters: params,
                progress: nil,
                success: successTask,
                failure: failureTask)
        }
    
    }

}
