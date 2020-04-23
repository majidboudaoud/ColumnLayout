//
//  CLStickyHeaderEffect.swift
//  
//
//  Created by Majid Boudaoud on 23/04/2020.
//

import UIKit

public class CLStickyHeaderEffect: CLLayoutEffectDelegate {
    
    public static func shouldInvalidateLayout(collectionView: UICollectionView) -> Bool {
        return true
    }
    
    private static func isFirstElementKindHeader(attributes: UICollectionViewLayoutAttributes) -> Bool {
        return attributes.representedElementKind == UICollectionView.elementKindSectionHeader
            && attributes.indexPath.section == 0
    }
    
    public static func computeEffectWithAttributes(attributes: [UICollectionViewLayoutAttributes],
                                                   collectionView: UICollectionView) {
        guard
            let firstHeaderAttributes = attributes.first(where: { isFirstElementKindHeader(attributes: $0) }),
            firstHeaderAttributes.frame.minY < collectionView.contentOffset.y else { return }
        let contentOffsetY = collectionView.contentOffset.y
        firstHeaderAttributes.zIndex = 1
        firstHeaderAttributes.frame = CGRect(x: firstHeaderAttributes.frame.minX,
                                             y: contentOffsetY,
                                             width: firstHeaderAttributes.frame.width,
                                             height: firstHeaderAttributes.frame.height)
    }
    
    public static func shouldAddAttributes(allAttributes: [UICollectionViewLayoutAttributes]) -> [UICollectionViewLayoutAttributes] {
        guard
            let firstHeaderAttributes = allAttributes.first(where: { isFirstElementKindHeader(attributes: $0) }) else { return [] }
        return [firstHeaderAttributes]
    }
}
