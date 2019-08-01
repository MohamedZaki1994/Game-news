//
//  ViewController+Alert.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 8/1/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, time: TimeInterval) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
