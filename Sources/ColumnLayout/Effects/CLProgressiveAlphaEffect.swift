//
//  CLProgressiveAlphaEffect.swift
//  
//
//  Created by Majid Boudaoud on 22/04/2020.
//

import UIKit

public class CLProgressiveAlphaEffect: CLLayoutEffectDelegate {
    
    public static func shouldInvalidateLayout(collectionView: UICollectionView) -> Bool {
        return true
    }
    
    private static func isFirstElementKindHeader(attributes: UICollectionViewLayoutAttributes) -> Bool {
        return attributes.representedElementKind == UICollectionView.elementKindSectionHeader
            && attributes.indexPath.section == 0
    }
    
    public static func computeEffectWithAttributes(attributes: [UICollectionViewLayoutAttributes],
                                                   collectionView: UICollectionView) {
        let contentOffsetY = collectionView.contentOffset.y
        attributes.forEach { (attribute) in
            let height = attribute.frame.height + attribute.frame.minY - contentOffsetY
            let alpha = height / attribute.frame.height
            attribute.alpha = alpha
        }
    }
}
