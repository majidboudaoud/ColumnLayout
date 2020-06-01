//
//  ColumnLayout.swift
//  ColumnLayoutExample
//
//  Created by Majid Boudaoud on 28/02/2019.
//  Copyright © 2019 Majid Boudaoud. All rights reserved.
//

import UIKit

public enum CLScrollDirection {
    case vertical
    case horizontal
}

public final class ColumnLayout: UICollectionViewLayout {
    
    // MARK: public properties

    public weak var delegate: ColumnLayoutDelegate?
    public var effects: [CLLayoutEffectDelegate.Type] = []
    public var scrollDirection: CLScrollDirection = .vertical
    
    // MARK: private properties
    
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat = 0
    private var headerAttributes: [UICollectionViewLayoutAttributes] = []
    private var cellAttributes: [UICollectionViewLayoutAttributes] = []
    
    override public var collectionViewContentSize: CGSize {
        guard let collectionView = self.collectionView else { return .zero }
        let width = scrollDirection == .vertical ? collectionView.bounds.width : contentWidth
        let height = scrollDirection == .horizontal ? collectionView.bounds.height : contentHeight
        return CGSize(width: width, height: height)
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
            let descriptor = CLLayoutDescriptor(delegate: delegate, section: section, collectionView: collectionView, scrollDirection: self.scrollDirection)
            self.computeHeaderAttributesFor(descriptor: descriptor)
            self.computeCellAttributesFor(descriptor: descriptor)
            self.contentHeight += descriptor.insets.bottom
        }
    }
    
    private func computeCellAttributesFor(descriptor: CLLayoutDescriptor) {
        switch descriptor.scrollDirection {
        case .vertical:
            let currentOffset: CGFloat = self.contentHeight
            let cellWidth = CLVerticalLayoutCalculator.calculateCellWidth(descriptor: descriptor)
            let cellHorizontalPositions = CLVerticalLayoutCalculator.calculateHorizontalValues(descriptor: descriptor,
                                                                                     cellWidth: cellWidth)
            let cellHeights = CLVerticalLayoutCalculator.calculateHeightValues(descriptor: descriptor)
            let cellVerticalPositions = CLVerticalLayoutCalculator.calculateVerticalValues(descriptor: descriptor,
                                                                                 currentOffset: currentOffset,
                                                                                 heightValues: cellHeights)
            for index in 0..<descriptor.numberOfItems {
                let indexPath = IndexPath(item: index, section: descriptor.section)
                let frame: CGRect = CGRect(x: cellHorizontalPositions[index % descriptor.numberOfColumns],
                                           y: cellVerticalPositions[index],
                                           width: cellWidth,
                                           height: cellHeights[index])
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                self.contentHeight = max(attributes.frame.maxY, contentHeight)
                self.cellAttributes.append(attributes)
            }
        case .horizontal:
            let currentOffset: CGFloat = self.contentWidth
            let cellWidth = CLHorizontalLayoutCalculator.calculateCellWidth(descriptor)
            let cellHeights = CLHorizontalLayoutCalculator.calculateHeightValues(descriptor)
            let cellVerticalPositions = CLHorizontalLayoutCalculator.calculateVerticalValues(descriptor, cellHeights)
            let cellHorizontalPositions = CLHorizontalLayoutCalculator.calculateHorizontalValues(currentOffset, descriptor, cellWidth)
            for index in 0..<descriptor.numberOfItems {
                let indexPath = IndexPath(item: index, section: descriptor.section)
                let frame: CGRect = CGRect(x: cellHorizontalPositions[index],
                                           y: cellVerticalPositions[index % descriptor.numberOfColumns],
                                           width: cellWidth[index],
                                           height: cellHeights)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                self.contentWidth = max(attributes.frame.maxX, contentHeight)
                self.cellAttributes.append(attributes)
            }
        }
    }
    
    private func computeHeaderAttributesFor(descriptor: CLLayoutDescriptor) {
        switch descriptor.scrollDirection {
        case .vertical:
            let indexPath = IndexPath(item: 0, section: descriptor.section)
            let offset = self.contentHeight
            let frame = CLVerticalLayoutCalculator.calculateHeaderAttributes(descriptor: descriptor, currentOffset: offset)
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                              with: indexPath)
            attributes.frame = frame
            self.contentHeight = attributes.frame.maxY
            self.headerAttributes.append(attributes)
        case .horizontal:
            let indexPath = IndexPath(item: 0, section: descriptor.section)
            let offset = self.contentWidth
            let frame = CLHorizontalLayoutCalculator.calculateHeaderAttributes(offset, descriptor)
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                              with: indexPath)
            attributes.frame = frame
            self.contentWidth = attributes.frame.maxX
            self.headerAttributes.append(attributes)
        }
    }
    
    override public func invalidateLayout() {
        super.invalidateLayout()
        self.contentHeight = 0
        self.cellAttributes.removeAll(keepingCapacity: true)
        self.headerAttributes.removeAll(keepingCapacity: true)
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = self.collectionView else { return false }
        let shouldInvalidate = effects.contains { $0.shouldInvalidateLayout(collectionView: collectionView) }
        return shouldInvalidate || newBounds.width != collectionView.bounds.width
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
        let addedAttributes = self.shouldAddAttributes()
        applyEffectsOnAttributes(attributes: visibleCellAttributes + visibleHeaderAttributes + addedAttributes)
        return visibleCellAttributes + visibleHeaderAttributes + addedAttributes
    }
    
    private func shouldAddAttributes() -> [UICollectionViewLayoutAttributes] {
        var attributes: [UICollectionViewLayoutAttributes] = []
        self.effects.forEach { (effect) in
            attributes.append(contentsOf: effect.shouldAddAttributes(allAttributes: self.headerAttributes + self.cellAttributes) )
        }
        return attributes
    }
    
    private func applyEffectsOnAttributes(attributes: [UICollectionViewLayoutAttributes]) {
        guard let collectionView = self.collectionView else { return }
        self.effects.forEach { (effectDelegate) -> Void in
           effectDelegate.computeEffectWithAttributes(attributes: attributes, collectionView: collectionView)
        }
    }
}
