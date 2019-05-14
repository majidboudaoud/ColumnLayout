//
//  CoreColumnLayout.swift
//  ColumnLayoutExample
//
//  Created by Majid Boudaoud on 01/03/2019.
//  Copyright © 2019 Majid Boudaoud. All rights reserved.
//

import UIKit

struct CoreColumnLayout {
    
    ///   Calculates a section cell width from the number of columns and available width.
    ///
    ///   - Parameters:
    ///      - descriptor: The descriptor object describing the current section layout behavior.
    ///
    ///   - Returns: An array of section cells height.
    static func calculateHeaderAttributes(availableWidth: CGFloat,
                                          height: CGFloat,
                                          currentOffset: CGFloat,
                                          insets: UIEdgeInsets) -> CGRect {
        let xPosition = insets.left
        let yPosition = currentOffset + insets.top
        let width = availableWidth - insets.left - insets.right
        return CGRect(x: xPosition, y: yPosition, width: width, height: height)
    }
    
    ///   Calculates a section cell width from the number of columns and available width.
    ///
    ///   - Parameters:
    ///      - descriptor: The descriptor object describing the current section layout behavior.
    ///
    ///   - Returns: An array of section cells height.
    static func calculateHeightValues(descriptor: CLLayoutDescriptor) -> [CGFloat] {
        var heightValues: [CGFloat] = []
        for index in 0..<descriptor.numberOfItems {
            let indexPath = IndexPath(item: index, section: descriptor.section)
            if let height = descriptor.delegate?.heightForCellAt(indexPath: indexPath) {
                heightValues.append(height)
            }
        }
        return heightValues
    }
    
    ///   Calculates a section cell width from the number of columns and available width.
    ///
    ///   - Parameters:
    ///      - availableWidth: The available width, should be the width of the collection view.
    ///      - numberOfColumns: The number of columns for a section.
    ///      - inset: The horizontal inset.
    ///
    ///   - Returns: The width of the specified item.
    static func calculateCellWidth(descriptor: CLLayoutDescriptor) -> CGFloat {
        let insets = descriptor.insets
        let interItemSpacing = descriptor.interItemSpacing
        let numberOfColumns = CGFloat(descriptor.numberOfColumns)
        let columnWidth = descriptor.availableWidth - insets.left - insets.right - ((numberOfColumns - 1) * interItemSpacing)
        let cellWidth = columnWidth / numberOfColumns
        return cellWidth
    }
    
    ///   Calculates the x positions for all cells in a given section and store them in an array.
    ///
    ///   - Parameters:
    ///      - cellWidth: The cell width.
    ///      - inset: The horizontal inset.
    ///      - numberOfColumns: The number of columns for a given section.
    ///
    ///   - Returns: The width of the specified item.
    static func calculateHorizontalValues(descriptor: CLLayoutDescriptor, cellWidth: CGFloat) -> [CGFloat] {
        var xPositions: [CGFloat] = []
        for i in 0..<descriptor.numberOfColumns {
            let index = CGFloat(i)
            let horizontalInsets: CGFloat = descriptor.insets.left + (index * descriptor.interItemSpacing)
            let cellWidth: CGFloat = index * cellWidth
            let x = horizontalInsets + cellWidth
            xPositions.append(x)
        }
        return xPositions
    }
    
    ///   Calculates the y positions for all cells in a given section and store them in an array.
    ///
    ///   - Parameters:
    ///      - numberOfItems: The number of items in a given section.
    ///      - numberOfColumns: The number of columns for a given section.
    ///
    ///   - Returns: The width of the specified item.
    static func calculateVerticalValues(descriptor: CLLayoutDescriptor,
                                        currentOffset: CGFloat,
                                        heightValues: [CGFloat]) -> [CGFloat] {
        let currentOffset = currentOffset + descriptor.lineSpacing
        let yPositions = heightValues.enumerated().map { (offset, height) -> CGFloat in
            return computeValues(fromValue: currentOffset,
                                 lineSpacing: descriptor.lineSpacing,
                                 index: offset,
                                 array: heightValues,
                                 numberOfColumns: descriptor.numberOfColumns)
        }
        return yPositions
    }
    
    ///   Calculate the y value for a given index.
    ///
    ///   - Parameters:
    ///      - index: The index from wich the computation is made.
    ///      - array: An array of height values.
    ///      - numberOfColumns: The number of columns for a given section.
    ///
    ///   - Returns: The width of the specified item.
    private static func computeValues(fromValue: CGFloat,
                                      lineSpacing: CGFloat,
                                      index: Int,
                                      array: [CGFloat],
                                      numberOfColumns: Int) -> CGFloat {
        var value: CGFloat = fromValue
        for index in stride(from: index % numberOfColumns, to: index, by: numberOfColumns) {
            value += array[index] + lineSpacing
        }
        return value
    }
}
