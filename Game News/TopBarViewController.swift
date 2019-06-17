//
//  TopBarViewController.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/9/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit

class TopBarViewController: UIViewController {

    var del: TopBardProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func backBtn(_ sender: Any) {
        del?.dismiss()
    }

}
