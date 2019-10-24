//
//  UserAccountViewModel.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/23.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class UserAccountViewModel {
  static let shareInstance :UserAccountViewModel = UserAccountViewModel()
  var account : UserAccount?
  
  //文件路径
  var accountPath :String {
    
    let sandboxPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    return (sandboxPath as NSString).appendingPathComponent("account.plist")
  }
  
  //是否登录
  var isLogin : Bool{
    if account == nil{
      return false
    }
    
    if account?.expires_date == nil {
      return false
    }
    
    if account!.expires_date!.compare(Date()) != .orderedDescending{
      return false
    }
    
    if account?.access_token != nil {
      return true
    }
    
    return false
  }//

  init() {
    
    account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
    
     }//
  }
  
  
