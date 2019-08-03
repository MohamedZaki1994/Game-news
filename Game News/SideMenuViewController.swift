//
//  SideMenuViewController.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 8/2/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit
protocol SideMenuActionProtocol {
   func close()
}
class SideMenuViewController: UIViewController {
    var delegate: SideMenuActionProtocol?
    @IBAction func closeButton(_ sender: Any) {
        delegate?.close()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
