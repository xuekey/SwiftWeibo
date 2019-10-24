//
//  AppDelegate.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/20.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var rootVC : UIViewController{
    
    let isLogin = UserAccountViewModel.shareInstance.isLogin
    return isLogin ? WBWelcomeViewController(): UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window?.frame = UIScreen.main.bounds
    window?.rootViewController = rootVC
    window?.makeKeyAndVisible()
    
    UINavigationBar.appearance().tintColor =  UIColor.orange
    return true
  }

  
}

