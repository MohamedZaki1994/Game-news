//
//  DetailedCollectionViewlayout.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 6/23/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit

class DetailedCollectionViewlayout: UICollectionViewFlowLayout {

    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 6
    let sectionHeaderHeight: CGFloat = 100

    // 3
    fileprivate var cache = [UICollectionViewLayoutAttributes]()

    // 4
    fileprivate var contentHeight: CGFloat = 0

    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

    override func prepare() {
        super.prepare()
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        // 2
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)

        // 3

        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {

            let indexPath = IndexPath(item: item, section: 0)
            // 4
          prepareHeaderAttributes(section: 0, collectionView: collectionView, headerYOffset: 10)

            let photoHeight = CGFloat.random(in: 20 ..< 150)
            let height = cellPadding * 2 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column] + sectionHeaderHeight, width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            // 6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height

            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }

//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let attributes = super.layoutAttributesForElements(in: rect)
//        var attributesCopy = [UICollectionViewLayoutAttributes]()
//
//        for itemAtt in attributes! {
//            let itemAttCopy = itemAtt.copy() as! UICollectionViewLayoutAttributes
//            changeLayoutAtt(itemAttCopy)
//            attributesCopy.append(itemAttCopy)
//        }
//        return attributesCopy
//    }



    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesCopy = [UICollectionViewLayoutAttributes]()

        for itemAtt in cache {
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


    fileprivate func prepareHeaderAttributes(section: Int, collectionView: UICollectionView, headerYOffset: CGFloat) {
        let indexPath = IndexPath(item: 0, section: section)
        let headerWidth = collectionView.frame.width
        let headerFrame = CGRect(x: 0, y: headerYOffset, width: headerWidth, height: sectionHeaderHeight)
        addHeaderAttributes(section: section, frame: headerFrame, indexPath: indexPath)
        contentHeight = max(contentHeight, headerFrame.maxY)
    }

    fileprivate func addHeaderAttributes(section: Int, frame: CGRect, indexPath: IndexPath) {
        let headerAttr = UICollectionViewLayoutAttributes(
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            with: indexPath)
        // item padding
        let insetFrame = frame.insetBy(dx: 0, dy: 5)
        headerAttr.frame = insetFrame
        cache.append(headerAttr)
    }

}
