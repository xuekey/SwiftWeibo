//
//  HomeViewController.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: BaseTableViewController {
   
    //MARK:-属性
//    private var since_id : String = "0"
    //MARK:-lazy
    private lazy var statusVMArray: [StatusViewModel] = [StatusViewModel]()
    private lazy var titleView :TitleButton = TitleButton()
    private lazy var popAnimate : PopViewAnimator = PopViewAnimator {[weak self] (isPersent) in
    self?.titleView.isSelected = isPersent
  }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      visitorView.addRotationAnim()
      
      if !isLogin {return}//如果登录了，执行后面的代码
      setupNav()
//      loadData()
      setupRefresh()
    }

}

//MARK:- 设置UI
extension HomeViewController{
  
  ///设置导航栏
  private func setupNav(){
    navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
    navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
    
    titleView.setTitle("coderLiu", for: .normal)
    navigationItem.titleView = titleView
    titleView.addTarget(self, action: #selector(titleViewClick(button:)), for: .touchUpInside)
  }
  
  private func setupRefresh(){
    let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))
    header?.beginRefreshing()
    tableView.mj_header = header
    
    let footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
    tableView.mj_footer = footer
  }
  
}

//MARK:- 属性监听
extension HomeViewController{
  @objc private func titleViewClick(button:UIButton){
    button.isSelected = !button.isSelected
    
    let popVc = WOPopViewController()
    popVc.modalPresentationStyle = .custom
    popVc.transitioningDelegate = popAnimate
    popAnimate.presentFrame = CGRect(x:UIScreen.main.bounds.size.width*0.5-90, y: 56, width: 180, height: 250)
    present(popVc, animated: true, completion: nil)
    
  }
}

//MARK:-网络请求
extension HomeViewController{
  ///上拉
  @objc private func loadNewData(){
    loadData()
  }
  
  ///下拉
  @objc private func loadMoreData(){
    let httpTool : HttpTool = HttpTool()
    let maxID = statusVMArray.last?.status?.mid ?? 0
    
    httpTool.loadHomeMoreStatuses (maxID: maxID ){(result, error) in
        if error != nil {
          self.tableView.mj_footer.endRefreshing()
          return
        }
        
        guard let array = result as?[AnyObject] else{
          self.tableView.mj_footer.endRefreshing()
          return
        }
        
        for statusDic in array{
          let st = Status(dict: statusDic as! [String : AnyObject])
          let stVM = StatusViewModel(status: st)
          self.statusVMArray.append(stVM)
        }
        
        //刷新
        self.tableView.reloadData()
        self.tableView.mj_footer.endRefreshing()
      }
    }//
    
  ///网络请求
  private func loadData(){
    let httpTool : HttpTool = HttpTool()
     
    let since_id = statusVMArray.first?.status?.mid ?? 0
    
    httpTool.loadHomeStatuses (sinceID: since_id){(result, error) in
      if error != nil {
        self.tableView.mj_header.endRefreshing()
        return
      }
      
      guard let array = result as?[AnyObject] else{
        self.tableView.mj_header.endRefreshing()
        return
      }
      
      var tempArr = [StatusViewModel]()
      for statusDic in array{
        let st = Status(dict: statusDic as! [String : AnyObject])
        let stVM = StatusViewModel(status: st)
        tempArr.append(stVM)
      }
      self.statusVMArray = tempArr + self.statusVMArray
      
      //刷新
      self.tableView.reloadData()
      self.tableView.mj_header.endRefreshing()
    }
  }//
}


//MARK:-tableview的代理
extension HomeViewController{
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return statusVMArray.count
  }//
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
    let stVM = statusVMArray[indexPath.row]
    cell.statusVM = stVM
    return cell
  }
  
}
