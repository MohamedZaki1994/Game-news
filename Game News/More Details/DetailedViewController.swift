//
//  DetailedViewController.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/22/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit
import RealmSwift

protocol TopBardProtocol {
    func dismiss()
}

class DetailedViewController: UIViewController, TopBardProtocol{


    @IBOutlet weak var arrowImage: UIImageView!
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
                    shadowView.transform = CGAffineTransform(translationX: 0, y: -100)
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
        ///////////// this for adding a new property or renaming an existing one ///////////////
//        let config = Realm.Configuration(
//            // Set the new schema version. This must be greater than the previously used
//            // version (if you've never set a schema version before, the version is 0).
//            schemaVersion: 1,
//            migrationBlock: { migration, oldSchemaVersion in
//                if oldSchemaVersion < 1 {
//                    // Apply any necessary migration logic here.
//                    migration.enumerateObjects(ofType: Favorite.className()) { (_, newText) in
//                        newText?["text2"] = ""
//                    }
//                }
//        })
//        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        let object = realm.objects(Favorite.self)
        try! realm.write {
            realm.delete(object)
        }
        try! realm.write {
            realm.add(Favorite(name: "GW2", text: "Best"))
        }
    }
    let realView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        doneLabel.isHidden = true
        let xib = UINib(nibName: "DetailedCollectionViewCell", bundle: Bundle.main)
        collectionView.register(xib, forCellWithReuseIdentifier: "cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrowImage.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
        UIView.animate(withDuration: 8.5) {
            self.arrowImage.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2) * 0.99)
        }
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
        animateBalloon()

//        let calayer = CAShapeLayer()
//        view.layer.addSublayer(calayer)
//        let bezier = UIBezierPath()
//        bezier.move(to: CGPoint.zero)
//        bezier.addLine(to: CGPoint(x: 0, y: -100))
//        calayer.path = bezier.cgPath
//        calayer.lineWidth = 50
//        calayer.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
//        calayer.strokeColor = UIColor.blue.cgColor
//
//        CATransaction.begin()
//        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
//        basicAnimation.duration = 2
//        basicAnimation.fromValue =  0
//        basicAnimation.toValue = CGFloat.pi
//        CATransaction.setCompletionBlock {
//            calayer.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY + 100)
//            calayer.layoutIfNeeded()
//        }
//        calayer.layoutIfNeeded()
//        calayer.add(basicAnimation, forKey: nil)
//        CATransaction.commit()

    }

    func dismiss() {
        dismiss(animated: true, completion: nil)
    }

    func animateBalloon() {
        let balloon = CALayer()
        balloon.contents = UIImage(named: "balloon")?.cgImage
        balloon.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.layer.insertSublayer(balloon, at: 0)

        let expandAnimation = CABasicAnimation(keyPath: "position")
        expandAnimation.fromValue = [0,0]
        expandAnimation.toValue = [view.frame.width,view.frame.height/2]
        expandAnimation.duration = 10
        expandAnimation.fillMode = .backwards
        expandAnimation.isRemovedOnCompletion = false

        let expandAnimation1 = CABasicAnimation(keyPath: "position")
        expandAnimation1.fromValue = [view.frame.width,view.frame.height/2]
        expandAnimation1.toValue = [0,view.frame.height]
        expandAnimation1.duration = 10
        expandAnimation1.beginTime = 10
        expandAnimation1.isRemovedOnCompletion = false

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [expandAnimation, expandAnimation1]
        animationGroup.duration = 20
        animationGroup.repeatCount = .infinity
        balloon.add(animationGroup, forKey: nil)
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
