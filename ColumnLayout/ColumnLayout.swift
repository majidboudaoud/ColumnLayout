//
//  ColumnLayout.swift
//  ColumnLayoutExample
//
//  Created by Majid Boudaoud on 28/02/2019.
//  Copyright © 2019 Majid Boudaoud. All rights reserved.
//

import UIKit

public class ColumnLayout: UICollectionViewLayout {
    
    public var stretchyHeaderEnabled: Bool = false
    public var delegate: ColumnLayoutDelegate?
    private var contentHeight: CGFloat = 0
    private var headerAttributes: [UICollectionViewLayoutAttributes] = []
    private var cellAttributes: [UICollectionViewLayoutAttributes] = []
    
    override public var collectionViewContentSize: CGSize {
        guard let collectionView = self.collectionView else { return .zero }
        return CGSize(width: collectionView.bounds.width, height: contentHeight)
    }
    
    final override public func prepare() {
        super.prepare()
        guard self.cellAttributes.count == 0 else { return }
        guard let collectionView = self.collectionView else { return }
        
        self.computeCollectionViewLayoutAttributes(collectionView: collectionView)
    }
    
    private func computeCollectionViewLayoutAttributes(collectionView: UICollectionView) {
        guard let delegate = self.delegate else { return }
        for section in 0..<collectionView.numberOfSections {
            let numberOfItems: Int = collectionView.numberOfItems(inSection: section)
            let numberOfColumns: Int = delegate.numberOfColumnsFor(section: section)
            let insets = delegate.insetForSectionAtIndex(section: section)
            let interItemSpacing: CGFloat = delegate.minimumInteritemSpacingForSection(section: section)
            let lineSpacing: CGFloat = delegate.minimumLineSpacingForSection(section: section)
            
            self.computeHeaderAttributesFor(section: section, insets: insets)
            self.computeCellAttributesFor(availableWidth: collectionView.bounds.width,
                                          section: section,
                                          numberOfItems: numberOfItems,
                                          numberOfColumns: numberOfColumns,
                                          insets: insets,
                                          interItemSpacing: interItemSpacing,
                                          lineSpacing: lineSpacing)
            self.contentHeight += insets.bottom
        }
    }
    
    private func computeCellAttributesFor(availableWidth: CGFloat,
                                          section: Int,
                                          numberOfItems: Int,
                                          numberOfColumns: Int,
                                          insets: UIEdgeInsets,
                                          interItemSpacing: CGFloat,
                                          lineSpacing: CGFloat) {
        let currentOffset: CGFloat = self.contentHeight
        let cellWidth = CoreColumnLayout.calculateCellWidth(availableWidth: availableWidth,
                                                            numberOfColumns: numberOfColumns,
                                                            interItemSpacing: interItemSpacing,
                                                            insets:insets)
        let cellHorizontalPositions = CoreColumnLayout.calculateHorizontalValues(cellWidth: cellWidth,
                                                                                 numberOfColumns: numberOfColumns,
                                                                                 interItemSpacing: interItemSpacing,
                                                                                 insets: insets)
        let cellHeights = self.calculateHeightValues(section: section,
                                                     numberOfItems: numberOfItems)
        let cellVerticalPositions = CoreColumnLayout.calculateVerticalValues(currentOffset: currentOffset,
                                                                             numberOfColumns: numberOfColumns,
                                                                             lineSpacing: lineSpacing,
                                                                             heightValues: cellHeights)
        for i in 0..<numberOfItems {
            let indexPath = IndexPath(item: i, section: section)
            let frame: CGRect = CGRect(x: cellHorizontalPositions[i % numberOfColumns],
                                       y: cellVerticalPositions[i],
                                       width: cellWidth,
                                       height: cellHeights[i])
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            self.contentHeight = max(attributes.frame.maxY, contentHeight)
            self.cellAttributes.append(attributes)
        }
    }
    
    private func computeHeaderAttributesFor(section: Int, insets: UIEdgeInsets) {
        guard let collectionView = self.collectionView else { return }
        let indexPath = IndexPath(item: 0, section: section)
        let width = collectionView.bounds.width
        let offset = self.contentHeight
        let height = self.delegate?.referenceHeightForHeaderInSection(section: section) ?? 0
        let frame = CoreColumnLayout.calculateHeaderAttributes(availableWidth: width,
                                                               height: height,
                                                               currentOffset: offset,
                                                               insets: insets)
        
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: indexPath)
        attributes.frame = frame
        self.contentHeight = attributes.frame.maxY
        self.headerAttributes.append(attributes)
    }
    
    func calculateHeightValues(section: Int,
                               numberOfItems: Int) -> [CGFloat] {
        var heightValues: [CGFloat] = []
        for index in 0..<numberOfItems {
            let indexPath = IndexPath(item: index, section: section)
            if let height = self.delegate?.heightForCellAt(indexPath: indexPath) {
                heightValues.append(height)
            }
        }
        return heightValues
    }
    
    override public func invalidateLayout() {
        super.invalidateLayout()
        self.contentHeight = 0
        self.cellAttributes.removeAll(keepingCapacity: true)
        self.headerAttributes.removeAll(keepingCapacity: true)
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if stretchyHeaderEnabled {
            return true
        }
        return newBounds.width != collectionView?.bounds.width
    }
    
    override public func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return headerAttributes.first { $0.indexPath == indexPath }
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttributes.first { $0.indexPath == indexPath }
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let visibleCellAttributes = cellAttributes.filter{ $0.frame.intersects(rect) }
        let visibleHeaderAttributes = headerAttributes.filter{ $0.frame.intersects(rect) }
        computeStretchyEffectWithAttributes(attributes: visibleHeaderAttributes)
        return visibleCellAttributes + visibleHeaderAttributes
    }
    
    func computeStretchyEffectWithAttributes(attributes: [UICollectionViewLayoutAttributes]?) {
        guard stretchyHeaderEnabled else { return }
        attributes?.forEach({ (attributes) in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0 {
                guard let collectionView = collectionView else { return }
                let contentOffsetY = collectionView.contentOffset.y
                if contentOffsetY > 0 {
                    return
                }
                let width = collectionView.frame.width
                let height = attributes.frame.height - contentOffsetY
                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
            }
        })
    }
}

struct BinarySearchController {
    
    static func performBinarySearch(cellAttributes: [UICollectionViewLayoutAttributes], rect: CGRect) -> [UICollectionViewLayoutAttributes] {
        var visibleCellAttributes = [UICollectionViewLayoutAttributes]()
        
        // Find any cell that sits within the query rect.
        guard let lastIndex = cellAttributes.indices.last,
            let firstMatchIndex = binSearch(rect, start: 0, end: lastIndex, cellAttributes: cellAttributes) else { return visibleCellAttributes }
        
        // Starting from the match, loop up and down through the array until all the attributes
        // have been added within the query rect.
        for attributes in cellAttributes[..<firstMatchIndex].reversed() {
            guard attributes.frame.maxY >= rect.minY else { break }
            visibleCellAttributes.append(attributes)
        }
        
        for attributes in cellAttributes[firstMatchIndex...] {
            guard attributes.frame.minY <= rect.maxY else { break }
            visibleCellAttributes.append(attributes)
        }
        
        return visibleCellAttributes
    }
    
    // Perform a binary search on the cached attributes array.
    private static func binSearch(_ rect: CGRect, start: Int, end: Int, cellAttributes: [UICollectionViewLayoutAttributes]) -> Int? {
        if end < start { return nil }
        let mid = (start + end) / 2
        let attr = cellAttributes[mid]
        if attr.frame.intersects(rect) {
            return mid
        } else {
            if attr.frame.maxY < rect.minY {
                return binSearch(rect, start: (mid + 1), end: end, cellAttributes: cellAttributes)
            } else {
                return binSearch(rect, start: start, end: (mid - 1), cellAttributes: cellAttributes)
            }
        }
    }
}
