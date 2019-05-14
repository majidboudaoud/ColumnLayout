//
//  CLLayoutEffectDelegate.swift
//  ColumnLayout
//
//  Created by Majid Boudaoud on 09/05/2019.
//  Copyright © 2019 Majid Boudaoud. All rights reserved.
//

import Foundation

public protocol CLLayoutEffectDelegate: class {
    static func computeEffectWithAttributes(attributes: [UICollectionViewLayoutAttributes], collectionView: UICollectionView)
}
