//
//  UIButton+Extension.swift
//  MicBlog
//
//  Created by maqianli on 2020/8/23.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit

extension UIButton{
    convenience init(name: String, bgName: String) {
        self.init()
        self.setImage(UIImage(named: name), for: .normal)
        self.setImage(UIImage(named: name + "_highlighted"), for: .highlighted)

        self.setBackgroundImage(UIImage(named: bgName), for: .normal)
        self.setBackgroundImage(UIImage(named: bgName + "_highlighted"), for: .highlighted)
    }
}
