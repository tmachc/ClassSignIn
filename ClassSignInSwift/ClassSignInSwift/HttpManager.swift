//
//  HttpManager.swift
//  weather
//
//  Created by tmachc on 16/3/14.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import Foundation
import Alamofire

class HttpManager {
    static let defaultManager = HttpManager()
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
//    func networkStatus() -> NetworkReachabilityManager {
//        return NetworkReachabilityManager.NetworkReachabilityStatus
//    }
    
    func getRequest(
        url url: String,
        params: [String: AnyObject]?,
        complete: (result: [String: AnyObject]!) -> Void)
    {
        var strParam: String = ""
        if (params != nil) {
            for (key, value) in params! {
                strParam += "\(key)=\(value)&"
            }
        }
        Alamofire.request(.GET, url + strParam, parameters: nil, encoding: .JSON, headers: nil).responseJSON {
            response in
            
//            print("1 --->>> ",response.request)  // original URL request
//            print("2 --->>> ",response.response) // URL response
//            print("4 --->>> ",response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("result --->>> \(JSON)")
                complete(result: JSON as! [String : AnyObject])
            }
            else {
                print("访问失败,没有返回值")
                complete(result: ["code": "1", "message": "网络请求失败"])
            }

        }
    }
}
