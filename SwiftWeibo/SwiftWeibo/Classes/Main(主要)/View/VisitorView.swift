//
//  VisitorView.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class VisitorView: UIView {

  class func visitorView()->(VisitorView){
    
    let visitorView : VisitorView = Bundle.main.loadNibNamed("VisitorView", owner: self, options: nil)?.last as! VisitorView
    
    return visitorView
  }
  
  //属性
  @IBOutlet weak var rotationView: UIImageView!
  @IBOutlet weak var iconV: UIImageView!
  @IBOutlet weak var tips: UILabel!
  @IBOutlet weak var registerBtn: UIButton!
  @IBOutlet weak var loginBtn: UIButton!
  
  
  
}

//方法
extension VisitorView{
  
  ///设置访客视图
  func setupVisitorViewContent(iconName:String, tip:String) {
    iconV.image = UIImage(named: iconName)
    tips.text = tip
    rotationView.isHidden = true
  }//setupVisitorViewContent
  
  ///添加动画
  func addRotationAnim(){
    
    let anim:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    anim.fromValue = 0
    anim.toValue = Double.pi*2
    anim.repeatCount = MAXFLOAT
    anim.duration = 5
    anim.isRemovedOnCompletion = false
    rotationView.layer.add(anim, forKey: nil)
    
  }
  
}
