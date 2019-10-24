//
//  HomeCell.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/23.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
  
  @IBOutlet weak var avatarImageV: UIImageView!
  @IBOutlet weak var screen_name: UILabel!
  @IBOutlet weak var create_at: UILabel!
  @IBOutlet weak var source: UILabel!
  @IBOutlet weak var wbText: UILabel!
  @IBOutlet weak var retweeted_text: UILabel!
  
  @IBOutlet weak var vipImage: UIImageView!
  @IBOutlet weak var leverImage: UIImageView!
  @IBOutlet weak var picView: HomePicCollectionView!
  @IBOutlet weak var picViewConstraint: NSLayoutConstraint!
  @IBOutlet weak var reBG: UIView!
  let margin :CGFloat = 10
  @IBOutlet weak var picViewTopH: NSLayoutConstraint!
  
  var statusVM : StatusViewModel?{
    didSet{
      guard let statusVM = statusVM else {
        return
      }
      
      //头像
      avatarImageV.sd_setImage(with: statusVM.profile_image_url, completed: nil)
     //昵称
      screen_name.text = statusVM.status?.user?.screen_name
      screen_name.textColor = UIColor.black
      if statusVM.verifiedImage != nil {
        screen_name.textColor = UIColor.orange
      }
      
      //发布日期
      create_at.text = statusVM.created_str
      //来源
      source.text = statusVM.sourceText
      //正文
      wbText.text = statusVM.status?.text
      vipImage.image = statusVM.verifiedImage
      leverImage.image = statusVM.mbrankImage
      
      //展示图片
      picViewConstraint.constant = calculatePicViewH(count: statusVM.picUrls.count)
      picView.picUrls = statusVM.picUrls
      
      //转发的微博
      if statusVM.status?.retweeted_status != nil {
        
        if let screenName = statusVM.status?.retweeted_status?.user?.screen_name,let text = statusVM.status?.retweeted_status?.text{
          
          retweeted_text.text = "@\(screenName): \(text)"
          
          retweeted_text.isHidden = false
          reBG.isHidden = false
          picViewTopH.constant = 10
        }
      }else{
        retweeted_text.text = ""
        retweeted_text.isHidden = true
        reBG.isHidden = true
        picViewTopH.constant = 0
        
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
   
     let layoutWH = (UIScreen.main.bounds.width-2*margin-4*margin)/3.0
     layout.itemSize = CGSize(width: layoutWH, height: layoutWH)
    layout.minimumInteritemSpacing = margin
    layout.minimumLineSpacing = margin
    layout.scrollDirection = .vertical
  }
  
}


extension HomeCell{
  private func calculatePicViewH(count: Int)->(CGFloat){
    
    if count == 0 { return 0 }
    let cols = 3
    var row  = (count-1) / cols+1
    let imagevWH :CGFloat = (UIScreen.main.bounds.width-2*margin-4*margin)/3.0
    if count == 4 {
       row = (count-1) / 2+1
    }
    return imagevWH*CGFloat(row)+CGFloat(row-1)*margin
  }
}
