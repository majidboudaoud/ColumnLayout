//
//  CLLayoutDescriptor.swift
//  ColumnLayout
//
//  Created by Majid Boudaoud on 09/05/2019.
//  Copyright © 2019 Majid Boudaoud. All rights reserved.
//

import Foundation

public class CLLayoutDescriptor {
    
    weak var delegate: ColumnLayoutDelegate?
    let section: Int
    let numberOfItems: Int
    let numberOfColumns: Int
    let insets: UIEdgeInsets
    let interItemSpacing: CGFloat
    let lineSpacing: CGFloat
    let availableWidth: CGFloat
    let availableHeight: CGFloat
    let headerHeight: CGFloat
    let headerWidth: CGFloat
    let scrollDirection: CLScrollDirection
    
    init(delegate: ColumnLayoutDelegate,
         section: Int,
         collectionView: UICollectionView,
         scrollDirection: CLScrollDirection) {
        self.delegate = delegate
        self.section = section
        self.numberOfItems = collectionView.numberOfItems(inSection: section)
        self.availableWidth = collectionView.bounds.width
        self.availableHeight = collectionView.bounds.height
        self.numberOfColumns = delegate.numberOfColumnsFor(section: section)
        self.insets = delegate.insetForSectionAtIndex(section: section)
        self.interItemSpacing = delegate.minimumInteritemSpacingForSection(section: section)
        self.lineSpacing = delegate.minimumLineSpacingForSection(section: section)
        self.headerHeight = delegate.referenceHeightForHeaderInSection(section: section)
        self.headerWidth = delegate.referenceWidthForHeaderInSection(section: section)
        self.scrollDirection = scrollDirection
    }
}
