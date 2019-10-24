//
//  TitleButton.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

//标题 + 图片的button
class TitleButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setTitleColor(UIColor.black, for: .normal)
    setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
    setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
    sizeToFit()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    titleLabel!.frame.origin.x = 0;
    imageView!.frame.origin.x = titleLabel!.frame.size.width + 5
    sizeToFit()
  }
}
