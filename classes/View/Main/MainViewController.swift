//
//  MainViewController.swift
//  MicBlog
//
//  Created by maqianli on 2020/8/20.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(title: "首页", imageName: "tabbar_home", vc:HomeViewController())
        addChild(title: "消息", imageName: "tabbar_message_center", vc:MessageViewController())
        addChild(title: "发现", imageName: "tabbar_discover", vc:DiscoverViewController())
        addChild(title: "我", imageName: "tabbar_profile", vc:ProfileViewController())
        
        //统一设置
        let item = UITabBarItem.appearance()
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue], for: .normal)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], for: .selected)
        
    }

}

//MARK: 添加child
extension MainViewController {
    
    func addChild(title:String, imageName:String, vc:UIViewController) {
        
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        //单独设置
//        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue], for: .normal)
//        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], for: .selected)
        
        
        addChild(vc)
    }
}
