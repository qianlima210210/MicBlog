//
//  MessageViewController.swift
//  MicBlog
//
//  Created by maqianli on 2020/8/20.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setInfo(image: UIImage(named: "visitordiscover_image_message"), title: "蜀道难，难于上青天;酒逢知己千杯少，话不投机半句多;酒逢知己千杯少，话不投机半句多")
    }
    

}
