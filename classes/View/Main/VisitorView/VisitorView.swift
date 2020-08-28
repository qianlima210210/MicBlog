//
//  VisitorView.swift
//  MicBlog
//
//  Created by maqianli on 2020/8/26.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit

 class VisitorView: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconHomeImageView: UIImageView!
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBAction func onLoginClickListener(_ sender: Any) {
        print("login")
    }
    
    @IBAction func onRegisterClickListener(_ sender: Any) {
        print("register")
    }
    
    
    //initWithFrame是UIView指定构造函数
    //使用纯代码创建UIView对象时，调用此方法
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //initWithCoder也是UIView指定构造函数
    //使用sb或xib创建UIView时，调用此方法
    required init?(coder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
    }
    
    //设置图片和提示信息
    func setInfo(image:UIImage?, title:String?) -> Void {
        noteLabel.text = title
        
        if image == nil {
            return
        }
        iconHomeImageView.image = nil
        iconImageView.image = image
    }
    
}























