//
//  DetailedViewController.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/22/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let topBarVC = storyboard.instantiateViewController(withIdentifier: "TopBarViewController")
        addChild(topBarVC)
        topBarVC.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        view.addSubview(topBarVC.view)
        topBarVC.didMove(toParent: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
