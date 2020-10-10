//
//  WelcomeViewController.swift
//  MicBlog
//
//  Created by maqianli on 2020/9/27.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var avatarBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var welback: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avatarBottomConstraint.constant = UIScreen.main.bounds.height * 0.7
        
        welback.alpha = 0.0
        UIView.animate(withDuration: 1.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: []) {
            self.view.layoutIfNeeded()
        } completion: { (_) in
            UIView.animate(withDuration: 0.3) {
                self.welback.alpha = 1.0
            } completion: { (_) in
                
            }

        }

    }

}


extension WelcomeViewController {
    func setupUI() -> Void {
        avatar.layer.cornerRadius = avatar.bounds.width / 2.0
        avatarBottomConstraint.constant = UIScreen.main.bounds.height * 0.3
        
        let url = URL(string: (UserAccount.userAccount?.avatar_large ?? ""))
        avatar.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"), options: [], context: nil)
        
    }
}
