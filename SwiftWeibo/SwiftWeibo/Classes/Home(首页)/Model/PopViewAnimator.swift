//
//  PopViewAnimator.swift
//  SwiftWeibo
//
//  Created by Apple on 2019/10/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PopViewAnimator: NSObject {
  private var isPresentAnimate:Bool = false
  var presentFrame = CGRect.zero
  
  var callBack:((_ needPresent:Bool)->())?
  init(callBack:((_ needPresent:Bool)->())?){
    self.callBack = callBack
  }
}


//MARK:- delegate
extension PopViewAnimator:UIViewControllerTransitioningDelegate{
  
  //改变弹出视图的尺寸
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    let presentVC = WOPresentationController(presentedViewController: presented, presenting: presenting)
      presentVC.presentFrame = presentFrame
    
    return presentVC
  }
  
  //自定义弹出动画
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    isPresentAnimate = true
    callBack!(isPresentAnimate)
    return self
  }
  
  //自定义消失动画
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    isPresentAnimate = false
    callBack!(isPresentAnimate)
    return self
  }
  
}

//MARK:-弹出动画的代理
extension PopViewAnimator:UIViewControllerAnimatedTransitioning{
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
    return 0.25
  }//

  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
    isPresentAnimate ? presentViewAnimate(transitionContext: transitionContext) :dismisViewAnimate(transitionContext: transitionContext)
  }
  
  private func presentViewAnimate(transitionContext: UIViewControllerContextTransitioning){
    let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
       transitionContext.containerView.addSubview(presentView)
       
       presentView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
       presentView.transform = CGAffineTransform(scaleX: 1.0, y: 0)
       
       UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
         
         presentView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
         
       }) { (_) in
         transitionContext.completeTransition(true)
       }
  }//
  
  private func dismisViewAnimate(transitionContext: UIViewControllerContextTransitioning){
    let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
    
    transitionContext.containerView.addSubview(dismissView)
    UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
      
      dismissView.transform = CGAffineTransform(scaleX: 1.0, y: 0.00001)
      
    }) { (_) in
      dismissView.removeFromSuperview()
      transitionContext.completeTransition(true)
    }
    
  }//
}
