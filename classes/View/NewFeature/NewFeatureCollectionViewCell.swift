//
//  NewFeatureCollectionViewCell.swift
//  MicBlog
//
//  Created by maqianli on 2020/9/26.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit

class NewFeatureCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var enterBtn: UIButton!
    
    var imageIndex: Int = 0 {
        didSet{
            imageView.image = UIImage(named: "\(imageIndex).png")
            enterBtn.isHidden = true
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func startAnimation() -> Void {
        enterBtn.isHidden = false
        enterBtn.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: 0.8, delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 6.0,
                       options: [],
                       animations: {
                        self.enterBtn.transform = CGAffineTransform.identity
        }) { (b) in
            
        }
    }

    @IBAction func enterBtnClickListener(_ sender: UIButton) {
        print("enterBtnClickListener")
        NotificationCenter.default.post(name: NSNotification.Name(SwitchRootViewControllerNotification), object: nil, userInfo: nil)
    }
}
