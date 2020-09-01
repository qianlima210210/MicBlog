//
//  VisitorView.swift
//  MicBlog
//
//  Created by maqianli on 2020/8/26.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit

//MARK: 定义协议
protocol VisitorViewDelegate : NSObjectProtocol {
    func onLoginClickListener()
    func onRegisterClickListener()
}

 class VisitorView: UIView {
    
    //MARK:定义代理
    weak var delegate: VisitorViewDelegate?
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconHomeImageView: UIImageView!
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBAction func onLoginClickListener(_ sender: Any) {
        
        delegate?.onLoginClickListener()
    }
    
    @IBAction func onRegisterClickListener(_ sender: Any) {
        
        delegate?.onRegisterClickListener()
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
            setAnimation()
            return
        }
        iconHomeImageView.image = nil
        iconImageView.image = image
    }
    
    func setAnimation() -> Void {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * Double.pi
        animation.repeatCount = MAXFLOAT
        animation.duration = 20
        animation.isRemovedOnCompletion = false
        
        iconImageView.layer.add(animation, forKey: nil)
    }
    
}























