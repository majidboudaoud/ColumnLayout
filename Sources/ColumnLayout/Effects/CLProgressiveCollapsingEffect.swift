//
//  CLProgressiveCollapsing.swift
//  
//
//  Created by Majid Boudaoud on 23/04/2020.
//

import UIKit

public class CLProgressiveCollapsingEffect: CLLayoutEffectDelegate {
    
    private struct Constants {
        static let spacing: CGFloat = 68
        static let minimumHeight: CGFloat = 43
    }
    
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
            guard contentOffsetY > attribute.frame.minY - Constants.spacing, !Self.isFirstElementKindHeader(attributes: attribute) else { return }
            let supposedHeight = attribute.frame.height + attribute.frame.minY - contentOffsetY - Constants.spacing
            let shouldStop: Bool = supposedHeight > Constants.minimumHeight
            let height = shouldStop ? supposedHeight : Constants.minimumHeight
            let y = shouldStop ? contentOffsetY + Constants.spacing : attribute.frame.maxY - Constants.minimumHeight
            if !shouldStop {
                let percentage = supposedHeight / Constants.minimumHeight
                let zoom: CGFloat = 1 - (0.05 * (1 - percentage))
                let scale = CATransform3DMakeScale(zoom, zoom, 1.0)
                let translate = CATransform3DMakeTranslation(0, 51 * (1 - percentage), -12)
                attribute.transform3D = CATransform3DConcat(scale, translate)
                attribute.alpha = percentage
            }
            attribute.frame = CGRect(x: attribute.frame.minX,
                                     y: y,
                                     width: attribute.frame.width,
                                     height: height)
        }
    }
}
