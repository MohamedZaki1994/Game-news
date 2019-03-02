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
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 200))
        path.addLine(to: CGPoint(x: 200, y: 400))
        path.addLine(to: CGPoint(x: 10, y: 400))
        path.close()
        path.fill()
        path.lineWidth = 3
        UIColor.green.setStroke()
        path.stroke()
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.red.cgColor
        layer.path = path.cgPath
        view.layer.addSublayer(layer)
        layer.lineWidth = 3
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
