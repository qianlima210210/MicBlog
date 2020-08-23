//
//  MainViewController.swift
//  MicBlog
//
//  Created by maqianli on 2020/8/20.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit

@objcMembers class MainViewController: UITabBarController {
    
    lazy var composeBtn: UIButton = UIButton(name: "tabbar_compose_icon_add", bgName: "tabbar_compose_button")

    override func viewDidLoad() {
        super.viewDidLoad()
        addChilds()
        setupComposeButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //会创建tabBar中的所有控制器对应的按钮
        super.viewWillAppear(animated)
        
        //将按钮移到同级最前
        tabBar.bringSubviewToFront(composeBtn)
        
    }

}

//MARK: 添加child
extension MainViewController {
    
    func composeBtnOnClickListener(sender:UIButton) -> Void {
        print(String(format: "%@", "composeBtnOnClickListener"))
    }
    
    func setupComposeButton() -> Void {
        tabBar.addSubview(composeBtn)
        let count = children.count
        let width = tabBar.bounds.width / CGFloat(count)
        
        composeBtn.frame = CGRect(x: 2 * width, y: 1, width: width, height: tabBar.bounds.height)
        
        composeBtn.addTarget(self, action: #selector(composeBtnOnClickListener(sender:)), for: .touchUpInside)
        
    }
    
    func addChilds() -> Void {
        addChild(title: "首页", imageName: "tabbar_home", vc:HomeViewController())
        addChild(title: "消息", imageName: "tabbar_message_center", vc:MessageViewController())
        
        addChild(UIViewController())
        
        addChild(title: "发现", imageName: "tabbar_discover", vc:DiscoverViewController())
        addChild(title: "我", imageName: "tabbar_profile", vc:ProfileViewController())
        
        //setTabBarTitleColor()
    }
    
    func addChild(title:String, imageName:String, vc:UIViewController) {
        setupTabbarItemTextStyle(vc: vc)
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        addChild(MainNavigationController(rootViewController: vc))
    }
    
    //统一设置
    func setTabBarTitleColor() {
        UITabBar.appearance().tintColor = UIColor.red
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
    }
    
    //单独设置tabbarItem文字颜色、字体（但是normal没生效啊）
    func setupTabbarItemTextStyle(vc: UIViewController) {
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.orange], for: .selected)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
    }

}
