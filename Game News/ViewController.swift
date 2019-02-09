//
//  ViewController.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/8/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var container: UIView!
    let count = 3
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
        return wrappedcell
    }
    
    @IBAction func btn(_ sender: Any) {
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

        rep.data()
           }
    override func viewDidLayoutSubviews() {
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    @objc func timerAction() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                print(self.row)
                self.view.layoutIfNeeded()
                self.row += 1
                if self.row == self.count {
                    self.row = 0
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
        if scrollView.contentOffset.x > 0.0 {
        pageController.currentPage = row + 1
            row += 1
            if row == 3 {
                row = 0
            }
        } else {
            pageController.currentPage = row - 1
            row -= 1
            if row == -1 {
                row = 0
            }
        }
    }

}

