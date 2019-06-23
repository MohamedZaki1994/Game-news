//
//  DetailedCollectionViewlayout.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 6/23/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit

class DetailedCollectionViewlayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var attributesCopy = [UICollectionViewLayoutAttributes]()

        for itemAtt in attributes! {
            let itemAttCopy = itemAtt.copy() as! UICollectionViewLayoutAttributes
            changeLayoutAtt(itemAttCopy)
            attributesCopy.append(itemAttCopy)
        }
        return attributesCopy
    }

    func changeLayoutAtt(_ attributes: UICollectionViewLayoutAttributes) {
        let collectionCenter = collectionView!.frame.size.height/2
        let offsetY = collectionView!.contentOffset.y
        let normalizedCenter = attributes.center.y - offsetY

        let maxDistance = itemSize.height + minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance)/maxDistance

        let alpha = ratio*0.5 + 0.5
        let scale = ratio*0.5 + 0.5
        attributes.alpha = alpha
        attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

}
