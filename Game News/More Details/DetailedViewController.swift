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
    @IBOutlet weak var doneLabel: UILabel!

    @IBOutlet weak var fickerLabel: UIButton!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func flicker(_ sender: Any) {
        let shadowView = UIView(frame: self.fickerLabel.frame)
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {

            UIView.animateKeyframes(withDuration: 10, delay: 0, animations: {

                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                    shadowView.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(shadowView)
                    self.view.sendSubviewToBack(shadowView)
                    shadowView.backgroundColor = .gray
                    shadowView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                })

                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1, animations: {
                    shadowView.transform = CGAffineTransform(translationX: 0, y: -80)
                })
            }, completion: { (_) in
                shadowView.removeFromSuperview()
                self.doneLabel.isHidden = false
            })
        }
        animator.startAnimation()
    }
    let realView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        doneLabel.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

}
