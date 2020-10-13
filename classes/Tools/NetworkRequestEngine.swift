//
//  NetworkRequestEngine.swift
//  MicBlog
//
//  Created by maqianli on 2020/9/14.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit
import Alamofire

class NetworkRequestEngine: NSObject {
    
    static let engine = NetworkRequestEngine()
    
    //MARK: 应用程序信息
    let appKey = "1069040971"
    let appSecret = "dced87f388fc65cf3eb6861e0614be24"
    let redirectUrl = "https://m.baidu.com"
    
    typealias JsonNetworkCallback = (AFDataResponse<Any>) -> Void
    typealias StringNetworkCallback = (AFDataResponse<String>) -> Void
    
}

//MARK:获取微博数据
extension NetworkRequestEngine{
    func loadStatus(completionHandler: @escaping JsonNetworkCallback) {
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parameters = ["access_token":UserAccount.userAccount!.accessToken!]
        
        jsonRequest(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: ["Accept":"application/json"]) { (dataResponse) in
            completionHandler(dataResponse)
        }
    }
}

//MARK: 用户相关方法
extension NetworkRequestEngine {
    func getUserInfo(completionHandler: @escaping JsonNetworkCallback) -> Void {
        let url = "https://api.weibo.com/2/users/show.json"
        let parameters = ["access_token":UserAccount.userAccount!.accessToken!, "uid":UserAccount.userAccount!.userID!]
        
        jsonRequest(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: ["Accept":"application/json"]) { (dataResponse) in
            completionHandler(dataResponse)
        }
    }
}

//MARK:封装请求方法
extension NetworkRequestEngine {
    //返回一个json对象
    func jsonRequest(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil,
                 encoding: ParameterEncoding = JSONEncoding.default,
                 headers: HTTPHeaders? = nil, completionHandler: @escaping JsonNetworkCallback) -> Void {
        let request = AF.request(convertible, method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: nil, requestModifier: nil)
        request.responseJSON { (dataResponse) in
            completionHandler(dataResponse)
        }
    }
    
    //返回一个字符串对象
    func stringRequest(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil,
                 encoding: ParameterEncoding = JSONEncoding.default,
                 headers: HTTPHeaders? = nil, completionHandler: @escaping StringNetworkCallback) -> Void {
        let request = AF.request(convertible, method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: nil, requestModifier: nil)
        request.responseString { (dataResponse) in
            completionHandler(dataResponse)
        }
    }
}

/*
 //按照如下使用
 NetworkRequestEngine.engine.request("http://httpbin.org/post", method: .post, parameters: ["name":"Jone", "age":12], encoding: JSONEncoding.default, headers: ["Accept":"application/json"]){(dataResponse) in
     
     switch dataResponse.result{
         case .success(let value):
             let className: AnyClass! = object_getClass(value)
             print(className!)
             print(value)
         
         case .failure(let failDic):
             print(failDic)
     }
 }
 */
