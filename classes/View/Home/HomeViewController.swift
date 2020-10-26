//
//  HomeViewController.swift
//  MicBlog
//
//  Created by maqianli on 2020/8/20.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if (UserAccount.userAccount?.isLogin ?? false) == false {
            visitorView?.setInfo(image: nil, title: "大漠孤山尽，长河落日圆;大漠孤山尽，长河落日圆;大漠孤山尽，长河落日圆")
            return
        }
        
        loadData()
    }
    
    override func setupContentContainerView() {
        
    }
    
    func loadData() {
        NetworkRequestEngine.engine.loadStatus { (dataResponse) in
            switch dataResponse.result{
                case .success(let value):
                    guard let dic =  value as? [String:Any] else {
                        return
                    }
                    guard let statuses = dic["statuses"] as? [[String:Any]] else {
                        return
                    }
                    print(statuses.count)
                    //遍历数组，字典转模型
                    //1、创建一个可变数组
                    var arrayM = [Status]()
                    //2、遍历数组
                    for item in statuses {
                        arrayM.append(Status(dict: item))
                    }
                    print(arrayM)
                    
                case .failure(let failDic):
                    print(failDic)
            }
        }
    }


}
