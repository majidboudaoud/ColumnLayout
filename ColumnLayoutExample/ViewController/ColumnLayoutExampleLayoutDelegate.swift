//
//  ColumnLayoutExampleLayoutDelegate.swift
//  ColumnLayoutExample
//
//  Created by Majid Boudaoud on 24/03/2020.
//  Copyright © 2020 Majid Boudaoud. All rights reserved.
//

import ColumnLayout

class ColumnLayoutExampleLayoutDelegate: ColumnLayoutDelegate {
    
    func numberOfColumnsFor(collectionView: UICollectionView, section: Int) -> Int {
        let section = ColumnLayoutExampleSectionType.allCases[section]
        return section.numberOfColumns
    }
    
    func referenceHeightForHeaderInSection(collectionView: UICollectionView, section: Int) -> CGFloat {
        let height = collectionView.bounds.height / 3
        return height
    }
    
    func heightForCellAt(collectionView: UICollectionView, indexPath: IndexPath) -> CGFloat { 200 }
    
    func minimumInteritemSpacingForSection(collectionView: UICollectionView, section: Int) -> CGFloat { 8 }
    
    func minimumLineSpacingForSection(collectionView: UICollectionView, section: Int) -> CGFloat { 8 }
    
    func insetForSectionAtIndex(collectionView: UICollectionView, section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 8, bottom: 10, right: 8)
    }
}
