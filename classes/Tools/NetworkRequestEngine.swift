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
    
    func request(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil,
                 encoding: ParameterEncoding = JSONEncoding.default,
                 headers: HTTPHeaders? = nil, completionHandler: @escaping (AFDataResponse<Any>) -> Void) -> Void {
        let request = AF.request(convertible, method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: nil, requestModifier: nil)
        request.responseJSON { (dataResponse) in
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
