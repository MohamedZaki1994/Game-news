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
        path.stroke()
        let shapedLayer = CAShapeLayer()
        shapedLayer.strokeColor = UIColor.red.cgColor
        shapedLayer.path = path.cgPath
        view.layer.addSublayer(shapedLayer)
        shapedLayer.lineWidth = 10
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 2
        shapedLayer.add(animation, forKey: "drawLine")
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
