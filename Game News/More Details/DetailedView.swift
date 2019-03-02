//
//  DetailedView.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 3/2/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit

class DetailedView: UIView {


    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 200))
        path.addLine(to: CGPoint(x: 200, y: 400))
        path.addLine(to: CGPoint(x: 10, y: 400))
        path.close()
        path.fill()
        path.lineWidth = 3
        UIColor.green.setStroke()
        path.stroke()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
