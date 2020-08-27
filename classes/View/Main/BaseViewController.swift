//
//  BaseViewController.swift
//  MicBlog
//
//  Created by maqianli on 2020/8/24.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    var statusBar_NavBar_View: UIView = UIView()
    var baseContainerView: UIView = UIView()
    
    var isLogin = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initSbuViews()
        
        isLogin ? setupBaseContainerView() : setupVisitorView()
    }
    
    func initSbuViews() -> Void {
        //设置状态栏+导航栏
        statusBar_NavBar_View.backgroundColor = .systemPink
        view.addSubview(statusBar_NavBar_View)
        var height = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.bounds.height ?? 0.0)
        
        statusBar_NavBar_View.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalToSuperview()
            maker.right.equalToSuperview()
            maker.height.equalTo(height)
        }
        
        //设置基本容器视图
        baseContainerView.backgroundColor = .orange
        view.addSubview(baseContainerView)
        height = tabBarController?.tabBar.bounds.height ?? 0.0
        
        baseContainerView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.top.equalTo(statusBar_NavBar_View.snp.bottom).offset(0)
            maker.bottom.equalTo(view.snp.bottom).offset(-height)
        }
    }
    
    func setupVisitorView() -> Void {
        print("setupVisitorView")
        let visitorView = Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as? VisitorView
        if let visitorView = visitorView {
            visitorView.backgroundColor = .blue
            baseContainerView.addSubview(visitorView)
            
            visitorView.snp.makeConstraints { (maker) in
                maker.left.equalTo(baseContainerView).offset(20)
                maker.right.equalTo(baseContainerView).offset(-20)
                maker.height.equalTo(300)
                maker.centerY.equalToSuperview()
            }
        }
    }

    func setupBaseContainerView() -> Void {
        print("setupBaseContainerView")
    }

}
