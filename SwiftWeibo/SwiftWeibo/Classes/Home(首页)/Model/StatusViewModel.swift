//
//  StatusViewModel.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/23.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {
  var status : Status?
  
  var sourceText :String?
  var created_str :String?
  
  //认证图片
  var verifiedImage : UIImage?
  //会员等级图片
  var mbrankImage :UIImage?
  var profile_image_url :URL?
  var picUrls :[URL] = [URL]()
  
  
  
  init(status:Status){
    self.status = status
    
    //对来源处理
    let source = status.source
    if source != nil  && source != ""{
      let location = (source! as NSString).range(of: ">").location+1
      let length = (source! as NSString).range(of: "a>").location - location-2
      sourceText = "来自  "+(source! as NSString).substring(with: NSRange(location: location, length: length))
    }
    
    //对时间处理
    if (status.created_at != nil){
      created_str = NSDate.createDateString(createAtStr: status.created_at!)
       }
    
    //认证图片
    guard let user = status.user else {
      return
    }
    
    let verified_type = user.verified_type
    switch verified_type {
         case 0:
           verifiedImage = UIImage(named: "avatar_vip")
         case 2,3,5:
           verifiedImage = UIImage(named: "avatar_enterprise_vip")
         case 220:
           verifiedImage = UIImage(named: "avatar_grassroot")
         default: break
           
      }
    
    //会员等级图片
    let mbrank = user.mbrank
    if mbrank < 7 &&  mbrank > 0{
    mbrankImage = UIImage(named: "common_icon_membership_level\(mbrank)")
     }
    
    profile_image_url = URL(string: user.profile_image_url ?? "")
      
    let picurlArray = status.pic_urls!.count != 0 ?status.pic_urls:status.retweeted_status?.pic_urls
    
    if let picurlArray = picurlArray {
      for picDic in picurlArray {
        
        guard let urlStr = picDic["thumbnail_pic"] else {
          continue
        }
        picUrls.append(URL(string: urlStr)!)
        
      }
    }
    
    
  }
}
