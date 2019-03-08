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
