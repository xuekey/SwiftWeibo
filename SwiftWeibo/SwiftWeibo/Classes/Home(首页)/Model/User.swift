//
//  User.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/23.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class User: NSObject {
  @objc var profile_image_url :String?
  @objc var screen_name :String?
  //认证
  @objc var verified_type :Int = -1
  //等级
  @objc var mbrank = 0
  
  //自定义的属性
  
  
  init(dict:[String : AnyObject]){
    super.init()
    setValuesForKeys(dict)
  }
  
  override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
