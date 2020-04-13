//
//  ColumnLayoutDelegate.swift
//  ColumnLayoutExample
//
//  Created by Majid Boudaoud on 30/03/2019.
//  Copyright © 2019 Majid Boudaoud. All rights reserved.
//

import UIKit

public protocol ColumnLayoutDelegate: class {
    func numberOfColumnsFor(collectionView: UICollectionView, section: Int) -> Int
    func heightForCellAt(collectionView: UICollectionView, indexPath: IndexPath) -> CGFloat
    func referenceHeightForHeaderInSection(collectionView: UICollectionView, section: Int) -> CGFloat
    func insetForSectionAtIndex(collectionView: UICollectionView, section: Int) -> UIEdgeInsets
    func minimumInteritemSpacingForSection(collectionView: UICollectionView, section: Int) -> CGFloat
    func minimumLineSpacingForSection(collectionView: UICollectionView, section: Int) -> CGFloat
}

public extension ColumnLayoutDelegate {
    
    func insetForSectionAtIndex(collectionView: UICollectionView, section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func heightForCellAt(collectionView: UICollectionView, indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfColumnsFor(collectionView: UICollectionView, section: Int) -> Int {
        return 1
    }
    
    func minimumInteritemSpacingForSection(collectionView: UICollectionView, section: Int) -> CGFloat {
        return 10.0
    }
    
    func minimumLineSpacingForSection(collectionView: UICollectionView, section: Int) -> CGFloat {
        return 10.0
    }
    
    func referenceHeightForHeaderInSection(collectionView: UICollectionView, section: Int) -> CGFloat {
        return 30.0
    }
}
