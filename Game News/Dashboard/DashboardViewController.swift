//
//  ViewController.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/8/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var container: UIView!
    let animatorobj = animator()
    var row = 0
    var lastContentOffsetX: CGFloat = 0.0
    var timer: Timer?
    var arrowIcon = [UIImageView]()
    var dashboardInteractor = DashboardInteractor()
    var imageArray = [String]()
    var viewModel = DashboardViewModel()
    var viewHeightCollapsed: NSLayoutConstraint?
    var viewHeightExtended: NSLayoutConstraint?
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let wrappedcell = cell as? CollectionViewCell else {
            return cell
        }
        wrappedcell.title.text = "hello\(indexPath.row)"
        wrappedcell.imageView.image = UIImage(named: imageArray[indexPath.row])
        return wrappedcell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let topBarVC = storyboard.instantiateViewController(withIdentifier: "TopBarViewController")
        addChild(topBarVC)
        topBarVC.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        view.addSubview(topBarVC.view)
        topBarVC.didMove(toParent: self)
        dashboardInteractor.getData { (model) in
            guard let games = model.names else {
                return
            }
            imageArray = games
            pageController.numberOfPages = imageArray.count
            self.collectionView.reloadData()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(didFinished), name: Notification.Name("didReceiveData"), object: nil)
        setupStackView()
        dashboardInteractor.testNotification()
    }

    deinit {
        timer?.invalidate()
        timer = nil
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
        NotificationCenter.default.removeObserver(self)
    }

    @objc func didFinished(nsNotification: Notification) {
        guard let data = nsNotification.userInfo as? [String: String] else {
            return
        }
        print(data)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        navigationController?.navigationBar.isHidden = true
    }

    @objc func timerAction() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
                self.row += 1
                self.lastContentOffsetX += self.collectionView.frame.width
                if self.row == self.imageArray.count {
                    self.row = 0
                    self.lastContentOffsetX = 0.0
                }
                self.pageController.currentPage = self.row
                let index = IndexPath(row: self.row, section: 0)
            self.collectionView.scrollToItem(at: index, at: .right , animated: true)
                self.view.layoutIfNeeded()
                self.collectionView.layoutIfNeeded()
               
            })
        }
        
    }

    func setupStackView() {
        for imj in imageArray.enumerated() {
            let image = UIImage(named: imj.element)
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            let label = UILabel()
            label.text = "Test"
            label.translatesAutoresizingMaskIntoConstraints = false
            let view = CustomView()
            view.addSubview(imageView)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.viewHeightCollapsed = view.heightAnchor.constraint(equalToConstant: 120)
                view.viewHeightCollapsed?.isActive = true
            view.more = label
            arrowIcon.append(UIImageView(image: UIImage(named: "arrowDown")))
            arrowIcon[imj.offset].backgroundColor = .red
            view.addSubview(arrowIcon[imj.offset])
            addIcon(imj, view)
            view.addSubview(label)
            addingLabel(label, imageView, view)
            let tap = UITAPGesture(target: self, action: #selector(handleAction))
            tap.tapedView = view
            tap.isOpened = false
            tap.tapedView?.icon = arrowIcon[imj.offset]
            stackView.addArrangedSubview(view)
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tap)
        }
    }

    fileprivate func addingLabel(_ label: UILabel, _ imageView: UIImageView, _ view: CustomView) {
        label.textColor = .red
        label.numberOfLines = 0
        label.text = "See more"
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    fileprivate func addIcon(_ imj: (offset: Int, element: String), _ view: CustomView) {
        arrowIcon[imj.offset].translatesAutoresizingMaskIntoConstraints = false
        arrowIcon[imj.offset].heightAnchor.constraint(equalToConstant: 20).isActive = true
        arrowIcon[imj.offset].widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowIcon[imj.offset].trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        arrowIcon[imj.offset].bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }

    @objc func handleAction(sender: UITAPGesture) {
        guard let tapedView = sender.tapedView,
        let isOpened = sender.isOpened,
        let icon = sender.tapedView?.icon else {return}
        if isOpened {
            tapedView.more?.alpha = 0.25
            UIView.animate(withDuration: 1) {
                tapedView.more?.alpha = 1
                tapedView.more?.text = "See more"
                tapedView.viewHeightExtended?.isActive = false
                tapedView.viewHeightCollapsed?.isActive = true //tapedView.heightAnchor.constraint(equalToConstant: 100).isActive = true
                sender.isOpened = false
                icon.transform = CGAffineTransform(rotationAngle: CGFloat(0))
                self.view.layoutIfNeeded()
            }
        } else {
            tapedView.more?.alpha = 0.25
            UIView.animate(withDuration: 1) {
                tapedView.more?.alpha = 1
                tapedView.more?.text = "here you are so you can go to this direction and try to find me"
                tapedView.viewHeightCollapsed?.isActive = false
                tapedView.viewHeightExtended = tapedView.heightAnchor.constraint(equalToConstant: 200)
                tapedView.viewHeightExtended?.isActive = true
                sender.isOpened = true
                icon.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController else {
            return
            
        }
        vc.transitioningDelegate = self
        present(vc, animated: true, completion: nil)
    }
}
class animator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else {return}
        toView.transform = CGAffineTransform(scaleX: -0.2, y: -0.2)
        UIView.animate(withDuration: 0.5, animations: {
            toView.transform = .identity
        }) { (_) in
            transitionContext.completeTransition(true)
        }
        containerView.addSubview(toView)
    }


}
extension DashboardViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animatorobj
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
