//
//  RootNavigation.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/22/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    
     func pushViewController(viewController: UIViewController)  {
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let topBarVC = storyboard.instantiateViewController(withIdentifier: "TopBarViewController")
        viewController.addChild(topBarVC)
        topBarVC.view.frame = CGRect(x: 0, y: 0, width: viewController.view.frame.width, height: 50)
        viewController.view.addSubview(topBarVC.view)
        topBarVC.didMove(toParent: viewController)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
