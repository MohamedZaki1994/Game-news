//
//  DashboardViewController+CollectionView.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/22/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import Foundation
import UIKit
extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}


extension DashboardViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // moving to the right
        if scrollView.contentOffset.x - lastContentOffsetX > 0.0 {
            pageController.currentPage = row + 1
            row += 1
            if row == imageArray.count {
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
}

extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = factory.makeViewController(with: .DetailedViewController) as? DetailedViewController else {
            return
        }
        vc.transitioningDelegate = self
        guard let cell = collectionView.cellForItem(at: indexPath) as? DashboardCollectionViewCell else {
            return
        }
        vc.selectedImage = cell.imageView.image
        present(vc, animated: true, completion: nil)
    }
}

extension DashboardViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let wrappedcell = cell as? DashboardCollectionViewCell else {
            return cell
        }
        wrappedcell.title.text = "hello\(indexPath.row)"
        wrappedcell.imageView.image = UIImage(named: imageArray[indexPath.row])
        return wrappedcell
    }
}
