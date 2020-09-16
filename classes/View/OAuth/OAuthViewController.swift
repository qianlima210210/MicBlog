//
//  OAuthViewController.swift
//  MicBlog
//
//  Created by maqianli on 2020/9/15.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit
import WebKit
import Alamofire


class OAuthViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var containerView: UIView!
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"

        // Do any additional setup after loading the view.
        self.initViews()
        self.initData()
    }
    
    deinit {
        print("OAuthViewController deinit")
    }
    
    @objc func onCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onAutoFill() {
        let js = "document.getElementById('loginName').value = 'qianlima210210@163.com';" + "document.getElementById('loginPassword').value = '';"
        webView.evaluateJavaScript(js, completionHandler: nil)
    }

    func initViews() -> Void {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(onCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "autoFill", style: .plain, target: self, action: #selector(onAutoFill))
        
        // 导航栏背景颜色
        self.navigationController?.navigationBar.barTintColor = .white
        // 导航栏标题字体颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor:UIColor.orange]
        // 导航栏左右按钮字体颜色
        self.navigationController?.navigationBar.tintColor = .orange
        
        self.containerView.addSubview(webView)
        webView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
    }
    
    func initData() -> Void {
        webView.navigationDelegate = self
        let request = try? URLRequest(url: NetworkRequestEngine.engine.oauthUrl, method: .get)
        if let request = request {
            webView.load(request)
        }
        
    }
    
    //MARK: WKNavigationDelegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url?.absoluteString.removingPercentEncoding
        if let url = url as NSString? {
            
            if url.hasPrefix("https://api.weibo.com/oauth2/default.html?code=") {
                
                let code = url.substring(from: String("https://api.weibo.com/oauth2/default.html?code=").count)
                print("----" + code)
                decisionHandler(.cancel)
                self.onCancel()
                return
                
            
            }else if (url.range(of:"error=access_denied")).length > 0{
                decisionHandler(.cancel)
                self.onCancel()
                return
            }
        }
        
        decisionHandler(.allow)
    }
    
    
}
