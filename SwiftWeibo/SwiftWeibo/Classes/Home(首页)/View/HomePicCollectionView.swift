//
//  HomePicCollectionView.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/24.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class HomePicCollectionView: UICollectionView {
  var picUrls:[URL] = [URL](){
    didSet{
      
      reloadData()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    dataSource = self
    delegate = self
    
  }

}

extension HomePicCollectionView:UICollectionViewDataSource,UICollectionViewDelegate{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return picUrls.count
  }//
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell:PicLayoutCell =  collectionView .dequeueReusableCell(withReuseIdentifier: "picCell", for: indexPath)as!PicLayoutCell
    
    cell.url = picUrls[indexPath.row]
    cell.backgroundColor = UIColor.purple
    return cell
  }//
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    print(cell?.frame)
  }
  
  
}


class PicLayoutCell: UICollectionViewCell {
  
  @IBOutlet weak var iconImageV: UIImageView!
  
  var url : URL?{
    didSet{
      guard let url = url else {
        return
      }
      
     iconImageV .sd_setImage(with: url, placeholderImage: UIImage(named: "empty_picture"), options: .retryFailed, completed: nil)
    }
  }
  
}

//class HomeCellFlowLayout: UICollectionViewFlowLayout {
//  override init() {
//    super.init()
//  }
//
//}
