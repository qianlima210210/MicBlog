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
    var accessToken = ""    //"2.002SUK3C_5a2KB1dfa5ebb9dVk7ZpC"
    
    typealias JsonNetworkCallback = (AFDataResponse<Any>) -> Void
    typealias StringNetworkCallback = (AFDataResponse<String>) -> Void
    
}

//MARK:OAuth相关方法
extension NetworkRequestEngine {
    var oauthUrl:String{
        //https://open.weibo.cn/oauth2/authorize
        let str = "https://open.weibo.cn/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUrl)&display=mobile"
        return str
    }
    
    func get_access_token(code:String) -> Void {
        let str = "https://api.weibo.com/oauth2/access_token"
        let parameters = ["client_id":appKey, "client_secret":appSecret, "grant_type":"authorization_code", "code":code, "redirect_uri":redirectUrl]
        
        jsonRequest(str, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: ["Accept":"application/json"]) { (dataResponse) in
            print(dataResponse)
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
