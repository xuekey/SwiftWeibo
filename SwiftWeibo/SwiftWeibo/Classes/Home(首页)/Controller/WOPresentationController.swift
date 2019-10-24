//
//  WOPresentationController.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WOPresentationController: UIPresentationController {
  
  //MARK:-属性
  var presentFrame = CGRect.zero
  //MARK:-lazy
  private lazy var coverView = UIView()
  
  override func containerViewWillLayoutSubviews() {
    super.containerViewWillLayoutSubviews()
    
    presentedView?.frame = presentFrame
     setupCoverView()
  }
}

//添加蒙版
extension WOPresentationController{
  
  private func setupCoverView(){
    coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
    coverView.frame = containerView!.bounds
    let panGes = UITapGestureRecognizer(target: self, action: #selector(dismiss))
    containerView?.addGestureRecognizer(panGes)
    containerView?.insertSubview(coverView, at: 0)
  }
}


//事件监听
extension WOPresentationController{
  ///手势
  @objc private func dismiss(){
    presentedViewController.dismiss(animated: true, completion: nil)
  }
}
