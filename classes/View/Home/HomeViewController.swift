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
                    guard let statuses = dic["statuses"] as? Array<[String:Any]> else {
                        return
                    }
                    print(statuses.count)
                    
                case .failure(let failDic):
                    print(failDic)
            }
        }
    }


}
