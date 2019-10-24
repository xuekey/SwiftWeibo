//
//  WBTabbarController.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/20.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBTabbarController: UITabBarController {

    private lazy var composeBtn = UIButton(imageName: "tabbar_compose_button", bgImageName: "tabbar_compose_icon_add")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComposeBtn()
    }
    
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    
  }

}

///设置UI
extension WBTabbarController{
  
  ///设置发布按钮
  func setupComposeBtn(){
    
    composeBtn.center = CGPoint(x: tabBar.center.x,y: self.tabBar.bounds.size.height*0.5)
    composeBtn.addTarget(self, action:#selector(composeBtnClick), for: .touchUpInside)
    tabBar.addSubview(composeBtn)
    
  }//
  
 
  
  
}

///事件监听
extension WBTabbarController {
  
  ///中间按钮点击
  @objc private func composeBtnClick(){
    
  }
}
