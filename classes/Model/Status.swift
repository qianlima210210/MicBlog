//
//  Status.swift
//  MicBlog
//
//  Created by maqianli on 2020/10/17.
//  Copyright © 2020 nn. All rights reserved.
//

import UIKit

@objcMembers class Status: NSObject {
    var id: Int = 0
    var text: String?
    var create_at: String?
    var source: String?
    
    init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
        let keys = ["id", "text", "create_at", "source"]
        return dictionaryWithValues(forKeys: keys).description
    }
}
