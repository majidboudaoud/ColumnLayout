//
//  ColumnLayout.swift
//  ColumnLayoutExample
//
//  Created by Majid Boudaoud on 28/02/2019.
//  Copyright © 2019 Majid Boudaoud. All rights reserved.
//

import UIKit

public class ColumnLayout: UICollectionViewLayout {
    
    // MARK: public properties

    public weak var delegate: ColumnLayoutDelegate?
    public var effects: [CLStretchyEffect.Type] = [CLStretchyEffect.self]
    
    // MARK: private properties
    
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
            let descriptor = CLLayoutDescriptor(delegate: delegate, section: section, collectionView: collectionView)
            self.computeHeaderAttributesFor(descriptor: descriptor)
            self.computeCellAttributesFor(descriptor: descriptor)
            self.contentHeight += descriptor.insets.bottom
        }
    }
    
    private func computeCellAttributesFor(descriptor: CLLayoutDescriptor) {
        let currentOffset: CGFloat = self.contentHeight
        let cellWidth = CoreColumnLayout.calculateCellWidth(descriptor: descriptor)
        let cellHorizontalPositions = CoreColumnLayout.calculateHorizontalValues(descriptor: descriptor,
                                                                                 cellWidth: cellWidth)
        let cellHeights = CoreColumnLayout.calculateHeightValues(descriptor: descriptor)
        let cellVerticalPositions = CoreColumnLayout.calculateVerticalValues(descriptor: descriptor,
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
    }
    
    private func computeHeaderAttributesFor(descriptor: CLLayoutDescriptor) {
        guard let collectionView = self.collectionView else { return }
        let indexPath = IndexPath(item: 0, section: descriptor.section)
        let width = collectionView.bounds.width
        let offset = self.contentHeight
        let height = self.delegate?.referenceHeightForHeaderInSection(section: descriptor.section) ?? 0
        let frame = CoreColumnLayout.calculateHeaderAttributes(availableWidth: width,
                                                               height: height,
                                                               currentOffset: offset,
                                                               insets: descriptor.insets)
        
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                          with: indexPath)
        attributes.frame = frame
        self.contentHeight = attributes.frame.maxY
        self.headerAttributes.append(attributes)
    }
    
    override public func invalidateLayout() {
        super.invalidateLayout()
        self.contentHeight = 0
        self.cellAttributes.removeAll(keepingCapacity: true)
        self.headerAttributes.removeAll(keepingCapacity: true)
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if self.effects.count > 0 {
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
        applyEffectsOnAttributes(attributes: visibleCellAttributes + visibleHeaderAttributes)
        return visibleCellAttributes + visibleHeaderAttributes
    }
    
    override public func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = self.layoutAttributesForItem(at: itemIndexPath)
        
        attributes?.transform = CGAffineTransform(
            translationX: 0,
            y: 500.0
        )
        
        return attributes
    }
    
    private func applyEffectsOnAttributes(attributes: [UICollectionViewLayoutAttributes]) {
        guard let collectionView = self.collectionView else { return }
        self.effects.forEach { (effectDelegate) -> Void in
           effectDelegate.computeEffectWithAttributes(attributes: attributes, collectionView: collectionView)
        }
    }
}
