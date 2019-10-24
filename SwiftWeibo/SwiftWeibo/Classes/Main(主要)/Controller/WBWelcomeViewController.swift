//
//  WBWelcomeViewController.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/23.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBWelcomeViewController: UIViewController {
    //MARK:-属性
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var avatarBottomHeightConstraint: NSLayoutConstraint!
  
   //MARK:-系统方法
  override func viewDidLoad() {
        super.viewDidLoad()
    let userAccountVM = UserAccountViewModel.shareInstance
    
    //设置头像
    avatarImageView.sd_setImage(with: URL(string: userAccountVM.account?.avatar_large ?? ""), placeholderImage: UIImage(named: "avatar_default"), options: .retryFailed, completed: nil)
    
    avatarBottomHeightConstraint.constant = UIScreen.main.bounds.size.height - 200
    
    UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
      
      self.view.layoutIfNeeded()
      
    }) { (finished) in
      //切换到主界面
       let main:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      
      UIApplication.shared.keyWindow?.rootViewController = main.instantiateInitialViewController()
    }
   }//
  
  
  
}
