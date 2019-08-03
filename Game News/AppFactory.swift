//
//  AppFactory.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 8/3/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit
class AppFactory {

    enum ViewController: String {
        case DetailedViewController
        case FavoriteViewController
        case SideMenuViewController
    }
    func makeViewController(with viewController: ViewController) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: viewController.rawValue)
    }
}
