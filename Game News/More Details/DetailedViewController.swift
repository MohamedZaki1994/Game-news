//
//  DetailedViewController.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/22/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let barView = UIView()
        view.addSubview(barView)
        barView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        barView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        barView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        barView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        let path = UIBezierPath()
        path.move(to: CGPoint(x: barView.frame.minX, y: 100))
        path.addLine(to: CGPoint(x: barView.frame.minX, y: 0))
//        path.addLine(to: CGPoint(x: 10, y: 400))
//        path.close()
//        path.fill()
        path.stroke()
        let shapedLayer = CAShapeLayer()
        shapedLayer.strokeColor = UIColor.blue.cgColor
        shapedLayer.path = path.cgPath
//        view.layer.addSublayer(shapedLayer)
        shapedLayer.lineWidth = 10
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 2
        shapedLayer.add(animation, forKey: "drawLine")
        barView.layer.addSublayer(shapedLayer)
        barView.translatesAutoresizingMaskIntoConstraints = false

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}
