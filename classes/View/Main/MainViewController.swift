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
        
        
        setTabBarTitleColor()
        
    }

}

//MARK: 添加child
extension MainViewController {
    
    func addChild(title:String, imageName:String, vc:UIViewController) {

        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        //setupTabbarItemTextStyle(vc: vc)
        addChild(vc)
    }
    
    //统一设置
    func setTabBarTitleColor() {
        if #available(iOS 13.0, *) {
            UITabBar.appearance().tintColor = UIColor.red
            UITabBar.appearance().unselectedItemTintColor = UIColor.black
        } else {
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], for: .selected)
        }
    }
    
    // 设置tabbarItem文字颜色、字体
    func setupTabbarItemTextStyle(vc: UIViewController) {
        if #available(iOS 13, *) {
            let appearance = UITabBarAppearance();
            // 设置未被选中的颜色、字体
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red];
            // 设置被选中时的颜色、字体
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange];
            vc.tabBarItem.standardAppearance = appearance;
        } else {
            //单独设置
            //vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], for: .normal)
            //vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.orange], for: .selected)
        }
    }

}
