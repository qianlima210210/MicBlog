//
//  AppDelegate.swift
//  MicBlog
//
//  Created by maqianli on 2020/8/19.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit
import MBProgressHUD


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = MainViewController()
        
        window?.makeKeyAndVisible()
        
        WeiboSDK.enableDebugMode(true)
        WeiboSDK.registerApp(NetworkRequestEngine.engine.appKey)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        WeiboSDK.handleOpen(url, delegate: self)
        return true
    }

}

extension AppDelegate : WeiboSDKDelegate {
    func didReceiveWeiboRequest(_ request: WBBaseRequest!) {
        
    }
    
    func didReceiveWeiboResponse(_ response: WBBaseResponse!) {
        //从这里获取token
        let rp = response as! WBAuthorizeResponse
        UserAccount.userAccount.accessToken = rp.accessToken
        
        let result:[String:Any] = ["userID":rp.userID ?? "", "accessToken":rp.accessToken ?? "", "expirationDate":rp.expirationDate ?? NSDate(), "refreshToken":rp.refreshToken ?? ""]
        
        UserAccount.userAccount.setValuesForKeys(result)
        
        //利用token获取用户信息
        if (UserAccount.userAccount.accessToken?.count ?? 0) > 0 {
            MBProgressHUD.showAdded(to: window!, animated: true)
            
            NetworkRequestEngine.engine.getUserInfo { [weak self] (dataResponse) in
                MBProgressHUD.hide(for: self!.window!, animated: true)
                
                switch dataResponse.result{
                    case .success(let value):
                        guard let dic =  value as? [String:Any] else {
                            return
                        }
                        
                        print(dic["avatar_large"] ?? "")
                        print(dic["name"] ?? "")
                        
                    case .failure(let failDic):
                        print(failDic)
                }
            }
        }
    }

    
}


/*
 ("http://httpbin.org/post", method: .post, parameters: ["name":"Jone", "age":12], encoding: URLEncoding.default, headers: ["Accept":"application/json"])
 
 POST /post HTTP/1.1
 Host: httpbin.org
 Content-Type: application/x-www-form-urlencoded; charset=utf-8
 Accept: application/json
 User-Agent:
 Accept-Language: zh-Hans-CN;q=1.0
 Accept-Encoding: br;q=1.0, gzip;q=0.9, deflate;q=0.8
 Content-Length: 16
 Connection: keep-alive

 age=12&name=Jone
 
 HTTP/1.1 200 OK
 Date: Tue, 15 Sep 2020 11:50:01 GMT
 Content-Type: application/json
 Content-Length: 569
 Server: gunicorn/19.9.0
 Access-Control-Allow-Origin: *
 Access-Control-Allow-Credentials: true
 Proxy-Connection: keep-alive

 {
   "args": {},
   "data": "",
   "files": {},
   "form": {
     "age": "12",
     "name": "Jone"
   },
   "headers": {
     "Accept": "application/json",
     "Accept-Encoding": "br;q=1.0, gzip;q=0.9, deflate;q=0.8",
     "Accept-Language": "zh-Hans-CN;q=1.0",
     "Content-Length": "16",
     "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
     "Host": "httpbin.org",
     "User-Agent": "",
     "X-Amzn-Trace-Id": "Root=1-5f60aa69-79ab628006fda5f8fda1bb14"
   },
   "json": null,
   "origin": "119.147.23.62",
   "url": "http://httpbin.org/post"
 }

 ("http://httpbin.org/post", method: .post, parameters: ["name":"Jone", "age":12], encoding: URLEncoding.queryString, headers: ["Accept":"application/json"])
 
 POST /post?age=12&name=Jone HTTP/1.1
 Host: httpbin.org
 Accept: application/json
 User-Agent:
 Accept-Language: zh-Hans-CN;q=1.0
 Content-Length: 0
 Accept-Encoding: br;q=1.0, gzip;q=0.9, deflate;q=0.8
 Connection: keep-alive

 HTTP/1.1 200 OK
 Date: Tue, 15 Sep 2020 12:17:28 GMT
 Content-Type: application/json
 Content-Length: 512
 Server: gunicorn/19.9.0
 Access-Control-Allow-Origin: *
 Access-Control-Allow-Credentials: true
 Proxy-Connection: keep-alive

 {
   "args": {
     "age": "12",
     "name": "Jone"
   },
   "data": "",
   "files": {},
   "form": {},
   "headers": {
     "Accept": "application/json",
     "Accept-Encoding": "br;q=1.0, gzip;q=0.9, deflate;q=0.8",
     "Accept-Language": "zh-Hans-CN;q=1.0",
     "Content-Length": "0",
     "Host": "httpbin.org",
     "User-Agent": "",
     "X-Amzn-Trace-Id": "Root=1-5f60b0d8-d91aedbcc81cfbd5801762b1"
   },
   "json": null,
   "origin": "119.147.23.62",
   "url": "http://httpbin.org/post?age=12&name=Jone"
 }

 ("http://httpbin.org/post", method: .post, parameters: ["name":"Jone", "age":12], encoding: URLEncoding.httpBody, headers: ["Accept":"application/json"])
 
 POST /post HTTP/1.1
 Host: httpbin.org
 Content-Type: application/x-www-form-urlencoded; charset=utf-8
 Accept: application/json
 User-Agent:
 Accept-Language: zh-Hans-CN;q=1.0
 Accept-Encoding: br;q=1.0, gzip;q=0.9, deflate;q=0.8
 Content-Length: 16
 Connection: keep-alive

 age=12&name=Jone
 
 HTTP/1.1 200 OK
 Date: Tue, 15 Sep 2020 12:19:58 GMT
 Content-Type: application/json
 Content-Length: 569
 Server: gunicorn/19.9.0
 Access-Control-Allow-Origin: *
 Access-Control-Allow-Credentials: true
 Proxy-Connection: keep-alive

 {
   "args": {},
   "data": "",
   "files": {},
   "form": {
     "age": "12",
     "name": "Jone"
   },
   "headers": {
     "Accept": "application/json",
     "Accept-Encoding": "br;q=1.0, gzip;q=0.9, deflate;q=0.8",
     "Accept-Language": "zh-Hans-CN;q=1.0",
     "Content-Length": "16",
     "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
     "Host": "httpbin.org",
     "User-Agent": "",
     "X-Amzn-Trace-Id": "Root=1-5f60b16e-ca6d1b98abd1583842a769ff"
   },
   "json": null,
   "origin": "119.147.23.62",
   "url": "http://httpbin.org/post"
 }

 ("http://httpbin.org/post", method: .post, parameters: ["name":"Jone", "age":12], encoding: JSONEncoding.default, headers: ["Accept":"application/json"])
 
 POST /post HTTP/1.1
 Host: httpbin.org
 Content-Type: application/json
 Accept: application/json
 User-Agent:
 Accept-Language: zh-Hans-CN;q=1.0
 Accept-Encoding: br;q=1.0, gzip;q=0.9, deflate;q=0.8
 Content-Length: 24
 Connection: keep-alive

 {"age":12,"name":"Jone"}
 
 HTTP/1.1 200 OK
 Date: Tue, 15 Sep 2020 14:22:09 GMT
 Content-Type: application/json
 Content-Length: 563
 Server: gunicorn/19.9.0
 Access-Control-Allow-Origin: *
 Access-Control-Allow-Credentials: true
 Proxy-Connection: keep-alive

 {
   "args": {},
   "data": "{\"age\":12,\"name\":\"Jone\"}",
   "files": {},
   "form": {},
   "headers": {
     "Accept": "application/json",
     "Accept-Encoding": "br;q=1.0, gzip;q=0.9, deflate;q=0.8",
     "Accept-Language": "zh-Hans-CN;q=1.0",
     "Content-Length": "24",
     "Content-Type": "application/json",
     "Host": "httpbin.org",
     "User-Agent": "",
     "X-Amzn-Trace-Id": "Root=1-5f60ce11-f644d07c8ec206381bad3cf0"
   },
   "json": {
     "age": 12,
     "name": "Jone"
   },
   "origin": "36.155.117.36",
   "url": "http://httpbin.org/post"
 }

 ("http://httpbin.org/post", method: .post, parameters: ["name":"Jone", "age":12], encoding: JSONEncoding.prettyPrinted, headers: ["Accept":"application/json"])
 
 POST /post HTTP/1.1
 Host: httpbin.org
 Content-Type: application/json
 Accept: application/json
 User-Agent:
 Accept-Language: zh-Hans-CN;q=1.0
 Accept-Encoding: br;q=1.0, gzip;q=0.9, deflate;q=0.8
 Content-Length: 35
 Connection: keep-alive

 {
   "age" : 12,
   "name" : "Jone"
 }
 
 HTTP/1.1 200 OK
 Date: Tue, 15 Sep 2020 14:24:40 GMT
 Content-Type: application/json
 Content-Length: 577
 Server: gunicorn/19.9.0
 Access-Control-Allow-Origin: *
 Access-Control-Allow-Credentials: true
 Proxy-Connection: keep-alive

 {
   "args": {},
   "data": "{\n  \"age\" : 12,\n  \"name\" : \"Jone\"\n}",
   "files": {},
   "form": {},
   "headers": {
     "Accept": "application/json",
     "Accept-Encoding": "br;q=1.0, gzip;q=0.9, deflate;q=0.8",
     "Accept-Language": "zh-Hans-CN;q=1.0",
     "Content-Length": "35",
     "Content-Type": "application/json",
     "Host": "httpbin.org",
     "User-Agent": "",
     "X-Amzn-Trace-Id": "Root=1-5f60cea8-fe7d62a6e55d2d94cd47a6bd"
   },
   "json": {
     "age": 12,
     "name": "Jone"
   },
   "origin": "59.63.206.206",
   "url": "http://httpbin.org/post"
 }

 ("http://httpbin.org/get", method: .get, parameters: ["name":"Jone", "age":12], encoding: URLEncoding.default, headers: ["Accept":"application/json"])
 
 GET /get?age=12&name=Jone HTTP/1.1
 Host: httpbin.org
 Accept: application/json
 User-Agent:
 Accept-Language: zh-Hans-CN;q=1.0
 Accept-Encoding: br;q=1.0, gzip;q=0.9, deflate;q=0.8
 Connection: keep-alive
 
 HTTP/1.1 200 OK
 Date: Tue, 15 Sep 2020 14:27:01 GMT
 Content-Type: application/json
 Content-Length: 420
 Server: gunicorn/19.9.0
 Access-Control-Allow-Origin: *
 Access-Control-Allow-Credentials: true
 Proxy-Connection: keep-alive

 {
   "args": {
     "age": "12",
     "name": "Jone"
   },
   "headers": {
     "Accept": "application/json",
     "Accept-Encoding": "br;q=1.0, gzip;q=0.9, deflate;q=0.8",
     "Accept-Language": "zh-Hans-CN;q=1.0",
     "Host": "httpbin.org",
     "User-Agent": "",
     "X-Amzn-Trace-Id": "Root=1-5f60cf35-2fc6291d28afc2cae17b634d"
   },
   "origin": "59.63.206.206",
   "url": "http://httpbin.org/get?age=12&name=Jone"
 }

 ("http://httpbin.org/get", method: .get, parameters: ["name":"Jone", "age":12], encoding: URLEncoding.queryString, headers: ["Accept":"application/json"])
 
 GET /get?age=12&name=Jone HTTP/1.1
 Host: httpbin.org
 Accept: application/json
 User-Agent:
 Accept-Language: zh-Hans-CN;q=1.0
 Accept-Encoding: br;q=1.0, gzip;q=0.9, deflate;q=0.8
 Connection: keep-alive

 HTTP/1.1 200 OK
 Date: Tue, 15 Sep 2020 14:28:30 GMT
 Content-Type: application/json
 Content-Length: 420
 Server: gunicorn/19.9.0
 Access-Control-Allow-Origin: *
 Access-Control-Allow-Credentials: true
 Proxy-Connection: keep-alive

 {
   "args": {
     "age": "12",
     "name": "Jone"
   },
   "headers": {
     "Accept": "application/json",
     "Accept-Encoding": "br;q=1.0, gzip;q=0.9, deflate;q=0.8",
     "Accept-Language": "zh-Hans-CN;q=1.0",
     "Host": "httpbin.org",
     "User-Agent": "",
     "X-Amzn-Trace-Id": "Root=1-5f60cf8e-3f91b52cc983a810fe6beec4"
   },
   "origin": "36.155.117.36",
   "url": "http://httpbin.org/get?age=12&name=Jone"
 }

 ("http://httpbin.org/get", method: .get, parameters: ["name":"Jone", "age":12], encoding: JSONEncoding.default, headers: ["Accept":"application/json"])
 
 按照上面传参，会产生如下错误：
 urlRequestValidationFailed(reason: Alamofire.AFError.URLRequestValidationFailureReason.bodyDataInGETRequest(24 bytes))
 
 ("http://httpbin.org/get", method: .get, parameters: ["name":"Jone", "age":12], encoding: JSONEncoding.prettyPrinted, headers: ["Accept":"application/json"])
  按照上面传参，会产生如下错误：
 urlRequestValidationFailed(reason: Alamofire.AFError.URLRequestValidationFailureReason.bodyDataInGETRequest(35 bytes))
 
 */
