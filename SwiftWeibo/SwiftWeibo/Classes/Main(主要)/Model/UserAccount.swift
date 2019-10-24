//
//  UserAccount.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/22.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding {
  
  
  
  ///token
  @objc var access_token:String?
  ///过期时间
  @objc var expires_in : TimeInterval = 0{
    didSet{
      expires_date = NSDate(timeIntervalSinceNow: expires_in)
    }
  }
  ///uid
  @objc var uid : String?
  ///过期日期
  @objc var expires_date : NSDate?
   ///头像
  @objc var avatar_large : String?
   ///昵称
  @objc var screen_name : String?
  
  init(dic:[String:AnyObject?]) {
    super.init()
    setValuesForKeys(dic as [String : Any])
  }
  
  override func setValue(_ value: Any?, forUndefinedKey key: String) {
  }//
  
      // MARK:- 归档&解档
  /// 解档的方法
  required init?(coder aDecoder: NSCoder) {
      access_token = aDecoder.decodeObject(forKey:"access_token") as? String
      uid = aDecoder.decodeObject(forKey:"uid") as? String
      expires_date = aDecoder.decodeObject(forKey:"expires_date") as? NSDate
      avatar_large = aDecoder.decodeObject(forKey:"avatar_large") as? String
      screen_name = aDecoder.decodeObject(forKey:"screen_name") as? String
  }
  
  /// 归档方法
  func encode(with coder: NSCoder) {
    coder.encode(access_token, forKey: "access_token")
    coder.encode(uid, forKey: "uid")
    coder.encode(expires_date, forKey: "expires_date")
    coder.encode(avatar_large, forKey: "avatar_large")
    coder.encode(screen_name, forKey: "screen_name")
  }
  
}

extension UserAccount{
  
}
