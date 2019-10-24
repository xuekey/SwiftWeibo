//
//  OAuthViewController.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/22.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import WebKit

class OAuthViewController: UIViewController {

   //MARK:-属性
  @IBOutlet weak var loginWeb: WKWebView!
  @IBOutlet weak var progressView: UIProgressView!
  private var observation: NSKeyValueObservation?
  
  override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        loadWebView()
        
    }//

}


//MARK:-UI设置
extension OAuthViewController {
  
  ///设置导航
  private func setupNav(){
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeBtnClick))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(fill))
     
    title = "首页登录"
  }//
  
  private func loadWebView(){
    
    let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
    
    loginWeb .load(URLRequest(url: URL(string: urlString)!))
    loginWeb.uiDelegate = self
    loginWeb.navigationDelegate = self
    
    
    //监听进度条改变
    observation = loginWeb.observe(\.estimatedProgress, options: .new){_, change in
    self.progressView.setProgress(Float(change.newValue!), animated: true)
      
      if change.newValue! >= 1.0{
        self.progressView.alpha = 0
      }
    }
  }//
}

//MARK:-事件监听
extension OAuthViewController {
  ///关闭
  @objc private func closeBtnClick(){
    self.dismiss(animated: true, completion: nil)
  }
  ///填充
  @objc private func fill(){
    let jsStr = "document.getElementById('userId').value= '328928303@qq.com';document.getElementById('passwd').value= 'xue910178';"
    loginWeb.evaluateJavaScript(jsStr) { (_, error) in
      
    }
  }//
  
}

//MARK:-WKUIDelegate,WKNavigationDelegate
extension OAuthViewController:WKUIDelegate,WKNavigationDelegate{
  
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    
    let urlStr = navigationAction.request.url?.absoluteString;
     
    guard urlStr != nil else {
      decisionHandler(.allow);
      return
    }
     
    guard (urlStr?.contains("code="))! else {
      decisionHandler(.allow);
      return
    }
    
    let code = urlStr!.components(separatedBy: "code=").last!
    
    getAccessTocken(code: code)
    decisionHandler(.cancel);
  }//
 
}

//设置请求用户信息
extension OAuthViewController{
  
  private func getAccessTocken(code:String){
    let httpTool : HttpTool = HttpTool()
    
    httpTool.getAccessToken(code: code) { (success, error) in
      
      if (error != nil) {
        return
      }
      
      guard (success != nil) else {
        return
      }
      
      //转成模型
      let userAccount :UserAccount = UserAccount(dic: success as! Dictionary)
      //获取用户信息
      self.getUserInfo(userAccount: userAccount)
    }
  }//
  
  private func getUserInfo(userAccount:UserAccount){
     let httpTool : HttpTool = HttpTool()
    
    guard let uid = userAccount.uid else {
      return
    }
    
    guard let token = userAccount.access_token else {
      return
    }
    
    httpTool.getUserInfoRequest(uid: uid, token: token) { (dic, error) in
      
      userAccount.avatar_large = dic?["avatar_large"] as? String
      userAccount.screen_name = dic?["screen_name"] as? String
      
      //存储路径
      let filePath = UserAccountViewModel.shareInstance.accountPath
      //存到沙盒
      NSKeyedArchiver.archiveRootObject(userAccount, toFile: filePath)
      
      //给userAccountVM的account 赋值
      UserAccountViewModel.shareInstance.account = userAccount
      
      //展示欢迎界面
      self.dismiss(animated: false) {
        UIApplication.shared.keyWindow?.rootViewController = WBWelcomeViewController()
      }
    }
     
  }//
}
