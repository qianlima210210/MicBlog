//
//  OAuthViewController.swift
//  MicBlog
//
//  Created by maqianli on 2020/9/15.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"

        // Do any additional setup after loading the view.
        self.initViews()
    }
    
    @objc func onCancel() {
        self.dismiss(animated: true, completion: nil)
    }

    func initViews() -> Void {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(onCancel))
        // 导航栏背景颜色
        self.navigationController?.navigationBar.barTintColor = .white
        // 导航栏标题字体颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor:UIColor.orange]
        // 导航栏左右按钮字体颜色
        self.navigationController?.navigationBar.tintColor = .orange
    }
    
}
