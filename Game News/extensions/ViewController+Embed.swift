//
//  ViewController+Embed.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 8/3/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit

extension UIViewController {

    func embed(child childViewController: UIViewController) {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)

    }

    func unEmbed(child childViewController: UIViewController.Type) {
        for viewContoller in children where viewContoller.isKind(of: childViewController) {
            viewContoller.willMove(toParent: nil)
            viewContoller.view.removeFromSuperview()
            viewContoller.removeFromParent()
        }
    }
}
