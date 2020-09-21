//
//  UserAccount.swift
//  MicBlog
//
//  Created by maqianli on 2020/9/18.
//  Copyright © 2020 nn. All rights reserved.
//

import Foundation

@objcMembers class UserAccount: NSObject, NSCoding {
    
    static var userAccount: UserAccount?
    
    var userID: String?
    var accessToken: String?
    var expirationDate: NSDate?
    var refreshToken: String?
    var avatar_large: String?
    var name: String?
    
    static var path: String {
        let document =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as NSString?
        if let document = document {
            return document.appendingPathComponent("userInfo.plist")
        }
        return ""
    }
    
    var isExpired: Bool{
        return UserAccount.userAccount?.expirationDate?.compare(NSDate() as Date) == ComparisonResult.orderedAscending
    }
    
    var isLogin: Bool {
        return (UserAccount.userAccount?.accessToken?.count ?? 0) > 0 ? true : false
    }
    
    private override init() {
        super.init()
    }
    
    //注意setValuesForKeys，原理是利用OC中的KVC，KVC底层实现是runtime，swift类型默认是不拥有runtime特性的。
    //所以，setValue(_ value:, key:)，value是需要能转成oc中的id对象的。
    override func setValuesForKeys(_ keyedValues: [String : Any]) {
        super.setValuesForKeys(keyedValues)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["userID", "accessToken", "expirationDate", "refreshToken", "avatar_large", "name"]).description
    }
    
    func saveToLocal() -> Void {
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.path)
    }
    
    class func readFromLocal() ->Void {
        userAccount = NSKeyedUnarchiver.unarchiveObject(withFile: UserAccount.path) as? UserAccount
        if userAccount == nil {
            userAccount = UserAccount()
        }else{
            //接着判断是否已过期
            if userAccount?.isExpired == true {
                userAccount = UserAccount()
            }

        }
    }
    
    //MARK:NSCoding
    func encode(with coder: NSCoder){
        coder.encode(userID, forKey: "userID")
        coder.encode(accessToken, forKey: "accessToken")
        coder.encode(expirationDate, forKey: "expirationDate")
        coder.encode(refreshToken, forKey: "refreshToken")
        coder.encode(avatar_large, forKey: "avatar_large")
        coder.encode(name, forKey: "name")
    }
    
    required init?(coder: NSCoder){
        userID = coder.decodeObject(forKey: "userID") as? String
        accessToken = coder.decodeObject(forKey: "accessToken") as? String
        expirationDate = coder.decodeObject(forKey: "expirationDate") as? NSDate
        refreshToken = coder.decodeObject(forKey: "refreshToken") as? String
        avatar_large = coder.decodeObject(forKey: "avatar_large") as? String
        name = coder.decodeObject(forKey: "name") as? String
    }
    

}
