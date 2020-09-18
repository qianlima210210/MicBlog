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
    var navBar_View: UIView = UIView()
    let titleLabel = UILabel()
    var baseContainerView: UIView = UIView()
    var visitorView:VisitorView?
    
    var isLogin = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initSbuViews()
        
        isLogin ? setupContentContainerView() : setupVisitorView()
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
        
        //添加导航栏视图
        navBar_View.backgroundColor = UIColor.white
        statusBar_NavBar_View.addSubview(navBar_View)
        navBar_View.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.height.equalTo((navigationController?.navigationBar.bounds.height ?? 0.0))
        }
        
        //添加导航栏上的登录、注册按钮、标题标签
        let login = UIButton(type: .custom)
        login.addTarget(self, action: #selector(onLoginClickListener), for: .touchUpInside)
        login.setTitle("登录", for: .normal)
        login.setTitleColor(.orange, for: .normal)
        navBar_View.addSubview(login)
        login.snp.makeConstraints { (maker) in
            maker.left.equalTo(navBar_View)
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.width.equalTo(60)
        }
        
        let register = UIButton(type: .custom)
        register.addTarget(self, action: #selector(onRegisterClickListener), for: .touchUpInside)
        register.setTitle("注册", for: .normal)
        register.setTitleColor(.orange, for: .normal)
        navBar_View.addSubview(register)
        register.snp.makeConstraints { (maker) in
            maker.right.equalTo(navBar_View)
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.width.equalTo(60)
        }
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textColor = .orange
        navBar_View.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(login.snp.right)
            maker.right.equalTo(register.snp.left)
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
        //设置基本容器视图
        baseContainerView.backgroundColor = UIColor(white: 233.0/255.0, alpha: 1.0)
        view.addSubview(baseContainerView)
        height = tabBarController?.tabBar.bounds.height ?? 0.0
        
        baseContainerView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.top.equalTo(statusBar_NavBar_View.snp.bottom).offset(0)
            maker.bottom.equalTo(view.snp.bottom).offset(-height)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleLabel.text = self.title
    }
    
    func setupVisitorView() -> Void {
        print("setupVisitorView")
        visitorView = Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as? VisitorView
        visitorView?.delegate = self
        if let visitorView = visitorView { 
            baseContainerView.addSubview(visitorView)
            
            visitorView.snp.makeConstraints { (maker) in
                maker.left.equalTo(baseContainerView).offset(20)
                maker.right.equalTo(baseContainerView).offset(-20)
                maker.height.equalTo(300)
                maker.centerY.equalToSuperview()
            }
        }
    }

    //具体由子类实现
    func setupContentContainerView() -> Void {
        print("setupContentContainerView")
    }

}

extension BaseViewController : VisitorViewDelegate{
    @objc func onLoginClickListener() {
        print("login")
        let request:WBAuthorizeRequest = WBAuthorizeRequest.request() as! WBAuthorizeRequest
        request.redirectURI = NetworkRequestEngine.engine.redirectUrl
        request.scope = "all"
        WeiboSDK.send(request)
    }
    
    @objc func onRegisterClickListener() {
        print("register")
    }
    
    
}
