//
//  DetailedViewController.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/22/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit

protocol TopBardProtocol {
    func dismiss()
}

class DetailedViewController: UIViewController, TopBardProtocol{


    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var doneLabel: UILabel!

    @IBOutlet weak var fickerLabel: UIButton!

    @IBOutlet weak var flickerBtn: UIButton!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func flicker(_ sender: Any) {
        let shadowView = UIView(frame: self.fickerLabel.frame)
        let animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.9) {

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
                DispatchQueue.main.async {
                    self.doneLabel.layer.borderWidth = 8
                    let basicAnimation = CABasicAnimation(keyPath: "borderWidth")
                    basicAnimation.duration = 2
                    basicAnimation.fromValue = 2
                    basicAnimation.toValue = 8
                    basicAnimation.repeatCount = .infinity
                    basicAnimation.isRemovedOnCompletion = false
                    self.doneLabel.layer.add(basicAnimation, forKey: nil)
                    self.view.layoutIfNeeded()
                }
            })
        }
        animator.startAnimation()

    }
    let realView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        doneLabel.isHidden = true
        let xib = UINib(nibName: "DetailedCollectionViewCell", bundle: Bundle.main)
        collectionView.register(xib, forCellWithReuseIdentifier: "cell")

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        flickerBtn.isHidden = false
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 5
        animation.fillMode = .backwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.fromValue = [-flickerBtn.frame.width/2,flickerBtn.frame.midY]
        animation.toValue = [flickerBtn.frame.midX,flickerBtn.frame.midY]
        animation.beginTime = CACurrentMediaTime() + 2
        flickerBtn.layer.add(animation, forKey: nil)

    }

    func dismiss() {
        dismiss(animated: true, completion: nil)
    }

}

extension DetailedViewController: UICollectionViewDelegate {

}

extension DetailedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! DetailedCollectionReusableView
        return header
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DetailedCollectionViewCell
        cell.label.text = "\(indexPath.row)"
        cell.label.backgroundColor = .red
        return cell
    }


}
extension DetailedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
