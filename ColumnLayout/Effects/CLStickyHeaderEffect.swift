//
//  CLStickyHeaderEffect.swift
//  ColumnLayout
//
//  Created by Majid Boudaoud on 09/05/2019.
//  Copyright © 2019 Majid Boudaoud. All rights reserved.
//

import Foundation

public class CLStickyHeaderEffect: CLLayoutEffectDelegate {
    
    public static func computeEffectWithAttributes(attributes: [UICollectionViewLayoutAttributes], collectionView: UICollectionView) {
        //        var layoutAttributes = attributes
        //        let headersNeedingLayout = NSMutableIndexSet()
        //        for attributes in layoutAttributes {
        //            if attributes.representedElementCategory == .cell {
        //                headersNeedingLayout.add(attributes.indexPath.section)
        //            }
        //        }
        //        headersNeedingLayout.enumerate { (index, stop) -> Void in
        //            let indexPath = IndexPath(item: 0, section: index)
        //            if let attributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath) {
        //                layoutAttributes.append(attributes)
        //            }
        //        }
        //
        //        for attributes in layoutAttributes {
        //            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
        //                let section = attributes.indexPath.section
        //                if let attributesForFirstItemInSection = layoutAttributesForItem(at: IndexPath(item: 0, section: section)),
        //                    let attributesForLastItemInSection = layoutAttributesForItem(at: IndexPath(item: collectionView!.numberOfItems(inSection: section) - 1, section: section))  {
        //                    var frame = attributes.frame
        //                    let offset = collectionView.contentOffset.y
        //
        //                    /* The header should never go further up than one-header-height above
        //                     the upper bounds of the first cell in the current section */
        //                    let minY = attributesForFirstItemInSection.frame.minY - frame.height - (attributesForFirstItemInSection.frame.minY - frame.maxY)
        //                    /* The header should never go further down than one-header-height above
        //                     the lower bounds of the last cell in the section */
        //                    let maxY = attributesForLastItemInSection.frame.maxY - frame.height
        //                    /* If it doesn't break either of those two rules then it should be
        //                     positioned using the y value of the content offset */
        //                    let y = min(max(offset, minY), maxY)
        //
        //                    frame.origin.y = y
        //                    attributes.frame = frame
        //                    attributes.zIndex = 99
        //                }
        //            }
        //        }
    }
}
