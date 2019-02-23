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
    let count = 3
    var row = 0
    var lastContentOffsetX: CGFloat = 0.0
    var dashboardInteractor = DashboardInteractor()
    let imageArray = ["Silkroad","LOL","Pubg"]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        dashboardInteractor.getData { (model) in
            print(model)
        }
        setupStackView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @objc func timerAction() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                print(self.row)
                self.view.layoutIfNeeded()
                self.row += 1
                self.lastContentOffsetX += self.collectionView.frame.width
                if self.row == self.count {
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
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // moving to the right
        if scrollView.contentOffset.x - lastContentOffsetX > 0.0 {
        pageController.currentPage = row + 1
            row += 1
            if row == 3 {
                row = 0
            }
        } else if scrollView.contentOffset.x - lastContentOffsetX < 0.0 {
            pageController.currentPage = row - 1
            row -= 1
            if row == -1 {
                row = 0
            }
        }
        lastContentOffsetX = scrollView.contentOffset.x
    }
    var viewHeightCollapsed: NSLayoutConstraint?
    var viewHeightExtended: NSLayoutConstraint?
    func setupStackView() {
        for imj in imageArray {
            let image = UIImage(named: imj)
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            let label = UILabel()
            label.text = "Test"
            label.translatesAutoresizingMaskIntoConstraints = false
            let view = CustomView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.viewHeightCollapsed = view.heightAnchor.constraint(equalToConstant: 120)
                view.viewHeightCollapsed?.isActive = true
            view.more = label
            view.addSubview(imageView)
            view.addSubview(label)
            label.textColor = .red
            label.numberOfLines = 0
            label.text = "See more"
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            let tap = UITAPGesture(target: self, action: #selector(handleAction))
            tap.tapedView = view
            tap.isOpened = false
            stackView.addArrangedSubview(view)
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tap)
        }
    }
    @objc func handleAction(sender: UITAPGesture) {
        guard let tapedView = sender.tapedView,
        let isOpened = sender.isOpened else {return}
        if isOpened {
            tapedView.more?.alpha = 0.25
            UIView.animate(withDuration: 1) {
                tapedView.more?.alpha = 1
                tapedView.more?.text = "See more"
                tapedView.viewHeightExtended?.isActive = false
                tapedView.viewHeightCollapsed?.isActive = true //tapedView.heightAnchor.constraint(equalToConstant: 100).isActive = true
                sender.isOpened = false
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
                self.view.layoutIfNeeded()
            }
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController else {
            return
            
        }
        self.pushViewController(viewController: vc)
    }
}
