//
//  CLStretchyEffect.swift
//  ColumnLayout
//
//  Created by Majid Boudaoud on 09/05/2019.
//  Copyright © 2019 Majid Boudaoud. All rights reserved.
//

import UIKit

public class CLStretchyEffect: CLLayoutEffectDelegate {
    
    public static func shouldInvalidateLayout(collectionView: UICollectionView) -> Bool {
        return collectionView.contentOffset.y <= collectionView.bounds.height
    }
    
    private static func isFirstElementKindHeader(attributes: UICollectionViewLayoutAttributes) -> Bool {
        return attributes.representedElementKind == UICollectionView.elementKindSectionHeader
            && attributes.indexPath.section == 0
    }
    
    public static func computeEffectWithAttributes(attributes: [UICollectionViewLayoutAttributes],
                                                   collectionView: UICollectionView) {
        guard
            collectionView.contentOffset.y <= 0,
            let firstHeaderAttributes = attributes.first(where: { isFirstElementKindHeader(attributes: $0) }) else { return }
        let contentOffsetY = collectionView.contentOffset.y
        let height = firstHeaderAttributes.frame.height + firstHeaderAttributes.frame.minY - contentOffsetY
        firstHeaderAttributes.frame = CGRect(x: firstHeaderAttributes.frame.minX,
                                             y: contentOffsetY,
                                             width: firstHeaderAttributes.frame.width,
                                             height: height)
    }
}
