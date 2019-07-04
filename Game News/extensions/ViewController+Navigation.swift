//
//  ViewController+Navigation.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 7/4/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func viewControllerFromStroyboard(id: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id)
    }
}
