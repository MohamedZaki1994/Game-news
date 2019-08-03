//
//  AnimationTransition.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 8/3/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit

class animator: NSObject, UIViewControllerAnimatedTransitioning {
    var flag = false
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else {return}
        if flag {
            toView.transform = CGAffineTransform(scaleX: -0.1, y: -0.1)
            UIView.animate(withDuration: 0.5, animations: {
                toView.transform = .identity
            }) { (_) in
                transitionContext.completeTransition(true)
            }
            containerView.addSubview(toView)
        } else {
            guard let fromView = transitionContext.view(forKey: .from) else {return}
            fromView.transform = CGAffineTransform(scaleX: 1, y: 1)
            UIView.animate(withDuration: 0.5, animations: {
                fromView.transform = CGAffineTransform(scaleX: -0.1, y: -0.1)
            }) { (_) in
                transitionContext.completeTransition(true)
            }
            containerView.addSubview(toView)
            containerView.bringSubviewToFront(fromView)
        }
    }
}
