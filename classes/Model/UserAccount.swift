//
//  UserAccount.swift
//  MicBlog
//
//  Created by maqianli on 2020/9/18.
//  Copyright © 2020 nn. All rights reserved.
//

import Foundation

@objcMembers class UserAccount: NSObject {
    var userID: String?
    var accessToken: String?
    var expirationDate: NSDate?
    var refreshToken: String?
    
    init(dict:[String:Any]) {
        super.init()
        //注意setValuesForKeys，原理是利用OC中的KVC，KVC底层实现是runtime，swift类型默认是不拥有runtime特性的。
        //所以，setValue(_ value:, key:)，value是需要能转成oc中的id对象的。
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["userID", "accessToken", "expirationDate", "refreshToken"]).description
    }

}
