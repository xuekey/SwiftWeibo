//
//  UIButton-Extension.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/20.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

extension UIButton {
  class func createButton(imageName:String ,bgImageName:String)->(UIButton){
    
    let btn = UIButton(imageName: imageName, bgImageName: bgImageName)
    return btn;
  }
  
  convenience init(imageName:String ,bgImageName:String){
    self.init()
    setBackgroundImage(UIImage.init(named: imageName), for: .normal)
    setBackgroundImage(UIImage.init(named: imageName+"_highlighted"), for: .highlighted)
    setImage(UIImage.init(named: bgImageName), for: .normal)
    setImage(UIImage.init(named: bgImageName+"_highlighted"), for: .highlighted)
       
    sizeToFit()
  }
}
