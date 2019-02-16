//
//  ViewController.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/8/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var container: UIView!
    let count = 3
    let imageArray = ["Silkroad","LOL","Pubg"]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    
    @IBOutlet weak var pageController: UIPageControl!
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let wrappedcell = cell as? CollectionViewCell else {
            return cell
        }
        wrappedcell.title.text = "hello\(indexPath.row)"
        wrappedcell.imageView.image = UIImage(named: imageArray[indexPath.row])
        return wrappedcell
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    var row = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let topBarVC = storyboard.instantiateViewController(withIdentifier: "TopBarViewController")
        addChild(topBarVC)
        view.addSubview(topBarVC.view)
        topBarVC.didMove(toParent: self)
        view.sendSubviewToBack(topBarVC.view)
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        rep.data()
        setupStackView()
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
    var lastContentOffsetX: CGFloat = 0.0
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
    func setupStackView() {
        for imj in imageArray {
            let image = UIImage(named: imj)
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 100).isActive = true
            view.addSubview(imageView)
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleAction))
            stackView.addArrangedSubview(view)
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tap)
        }
    }
    @objc func handleAction() {
        print("welcome")
    }

}
extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
