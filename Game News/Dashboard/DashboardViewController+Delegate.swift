//
//  DashboardViewController+Delegate.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 8/3/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit

extension DashboardViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatorobj.flag = true
        return animatorobj
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatorobj.flag = false
        return animatorobj
    }
}


extension DashboardViewController: SideMenuActionProtocol {
    func close() {
        closeSideMenu()
    }

    func openSecondPage() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {return}
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}


