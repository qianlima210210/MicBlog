//
//  ProfileViewController.swift
//  MicBlog
//
//  Created by maqianli on 2020/8/20.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setInfo(image: UIImage(named: "visitordiscover_image_profile"), title: "酒逢知己千杯少，话不投机半句多;酒逢知己千杯少，话不投机半句多;酒逢知己千杯少，话不投机半句多")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
