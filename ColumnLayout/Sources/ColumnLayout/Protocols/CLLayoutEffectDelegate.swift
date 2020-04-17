//
//  CLLayoutEffectDelegate.swift
//  ColumnLayout
//
//  Created by Majid Boudaoud on 09/05/2019.
//  Copyright © 2019 Majid Boudaoud. All rights reserved.
//

import UIKit

public protocol CLLayoutEffectDelegate: class {
    static func shouldInvalidateLayout(collectionView: UICollectionView) -> Bool
    static func computeEffectWithAttributes(attributes: [UICollectionViewLayoutAttributes], collectionView: UICollectionView)
}

public extension CLLayoutEffectDelegate {
    static func shouldInvalidateLayout(collectionView: UICollectionView) -> Bool {
        return false
    }
}
