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
    weak var collectionView: UICollectionView?
    let section: Int
    let numberOfItems: Int
    let numberOfColumns: Int
    let insets: UIEdgeInsets
    let interItemSpacing: CGFloat
    let lineSpacing: CGFloat
    let availableWidth: CGFloat
    let headerHeight: CGFloat
    
    init(delegate: ColumnLayoutDelegate, section: Int, collectionView: UICollectionView) {
        self.delegate = delegate
        self.collectionView = collectionView
        self.section = section
        self.numberOfItems = collectionView.numberOfItems(inSection: section)
        self.availableWidth = collectionView.bounds.width
        self.numberOfColumns = delegate.numberOfColumnsFor(collectionView: collectionView, section: section)
        self.insets = delegate.insetForSectionAtIndex(collectionView: collectionView, section: section)
        self.interItemSpacing = delegate.minimumInteritemSpacingForSection(collectionView: collectionView, section: section)
        self.lineSpacing = delegate.minimumLineSpacingForSection(collectionView: collectionView, section: section)
        self.headerHeight = delegate.referenceHeightForHeaderInSection(collectionView: collectionView, section: section)
    }
}
