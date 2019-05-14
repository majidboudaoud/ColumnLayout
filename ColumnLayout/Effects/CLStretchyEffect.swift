//
//  CLStretchyEffect.swift
//  ColumnLayout
//
//  Created by Majid Boudaoud on 09/05/2019.
//  Copyright © 2019 Majid Boudaoud. All rights reserved.
//

import Foundation

public class CLStretchyEffect: CLLayoutEffectDelegate {
    
    public static func computeEffectWithAttributes(attributes: [UICollectionViewLayoutAttributes],
                                                   collectionView: UICollectionView) {
        attributes.forEach({ (attributes) in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader, attributes.indexPath.section == 0 {
                let contentOffsetY = collectionView.contentOffset.y
                let height = attributes.frame.height + attributes.frame.minY - contentOffsetY
                attributes.frame = CGRect(x: attributes.frame.minX,
                                          y: contentOffsetY,
                                          width: attributes.frame.width, height: height)
            }
        })
    }
}
