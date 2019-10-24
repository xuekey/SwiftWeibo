//
//  HttpTool.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/22.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Alamofire

class HttpTool: NSObject {
 
}


//POST GET
extension HttpTool {
  
  func GET(url:String, params:[String:AnyObject],finished :@escaping (_ result : AnyObject?, _ error : NSError?) -> ()) {
    
       Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: [:]).responseJSON { (response) in
         //是否请求成功
         switch response.result{
         case .success(let value):
          finished(value as AnyObject, nil)
         case .failure(let err):
          finished(nil, err as NSError)
        }
      }
  }//
  
     func POST(url:String, params:[String:AnyObject],finished :@escaping (_ result : AnyObject?, _ error : NSError?) -> ()) {
    
       Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: [:]).responseJSON { (response) in
         //是否请求成功
         switch response.result{
         case .success(let value):
          finished(value as AnyObject, nil)
         case .failure(let err):
          finished(nil, err as NSError)
        }
      }
  }//
}

///accessToken
extension HttpTool{
  ///获取token
  func getAccessToken(code:String,finished :@escaping (_ result : AnyObject?, _ error : NSError?) -> ())  {
    let urlStr = "https://api.weibo.com/oauth2/access_token"
    
    let params = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : "authorization_code", "redirect_uri" : redirect_uri, "code" : code]
    
    POST(url: urlStr, params: params as [String : AnyObject], finished: finished)
  }

}

///获取用户信息
extension HttpTool{
  ///获取用户信息
   func getUserInfoRequest(uid:String,token:String,finished :@escaping (_ result : AnyObject?, _ error : NSError?) -> ())  {
       let urlStr = "https://api.weibo.com/2/users/show.json"
       let params = ["uid":uid,"access_token":token]
     GET(url: urlStr, params: params as [String : AnyObject], finished: finished)
   }
}

///获取主页的微博
extension HttpTool{
  
  func loadHomeStatuses(sinceID:Int ,finished :@escaping (_ result : AnyObject?, _ error : NSError?) -> ()){
    
    let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
    let params = ["access_token":UserAccountViewModel.shareInstance.account?.access_token,"since_id":String(sinceID)]
    GET(url: urlStr, params: params as [String : AnyObject]) { (result , error) in
       
      guard let dic = result else{
        finished(nil,error)
        return
      }
      
      finished(dic["statuses"] as AnyObject,error)
      
    }
  }//
  
  func loadHomeMoreStatuses(maxID:Int ,finished :@escaping (_ result : AnyObject?, _ error : NSError?) -> ()){
    let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
    
    var max_id = 0
    if maxID > 0 {
      max_id = maxID - 1
    }
    
    let params = ["access_token":UserAccountViewModel.shareInstance.account?.access_token,"max_id":String(max_id)]
    GET(url: urlStr, params: params as [String : AnyObject]) { (result , error) in
       
      guard let dic = result else{
        finished(nil,error)
        return
      }
      
      finished(dic["statuses"] as AnyObject,error)
      
    }
  }//
}
