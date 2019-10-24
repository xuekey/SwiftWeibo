//
//  Statuses.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/23.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class Status: NSObject {
  ///创建时间
  @objc var created_at : String?
   ///来源
  @objc var source : String?
   ///正文
  @objc var text : String?
   ///微博id
  @objc var mid : Int = 0
  @objc var user: User?
  @objc var pic_urls : [[String:String]]?
  @objc var retweeted_status : Status?
  
  
  init(dict:[String:AnyObject]){
    super.init()
    
    setValuesForKeys(dict)
    if let userDict = dict["user"] as?[String :AnyObject]{
      user = User(dict: userDict)
    }
    
    if let retweetedStatus = dict["retweeted_status"]as?[String:AnyObject] {
        retweeted_status = Status(dict: retweetedStatus)
    }
    
  }
  
  override func setValue(_ value: Any?, forUndefinedKey key: String) {}
  
}
