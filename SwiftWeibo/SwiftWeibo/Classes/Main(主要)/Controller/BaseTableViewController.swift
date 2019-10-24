//
//  BaseTableViewController.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    var isLogin : Bool = UserAccountViewModel.shareInstance.isLogin
  
    lazy var visitorView:VisitorView = VisitorView.visitorView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
      //tableView.rowHeight = UITableView.automaticDimension
      //tableView.estimatedRowHeight = 200;
    }
  
  override func loadView(){
     isLogin ? super.loadView():setupVisitorView()
   }
  
}

//MARK:-设置UI
extension BaseTableViewController{
  ///添加访客视图
  private func setupVisitorView(){
    view = visitorView
    visitorView.registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
    visitorView.loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
  }
  
  ///设置导航栏
  private func setupNav(){
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerBtnClick))
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginBtnClick))
    
  }
  
}//设置UI

//MARK:-方法调用
extension BaseTableViewController{
  @objc private func registerBtnClick(){
    print("left")
  }
  
  @objc private func loginBtnClick(){
    let oauthVC = OAuthViewController()
    
    let nav : UINavigationController = UINavigationController(rootViewController: oauthVC)
    present(nav, animated: true, completion: nil)
  }
  
}//方法调用
