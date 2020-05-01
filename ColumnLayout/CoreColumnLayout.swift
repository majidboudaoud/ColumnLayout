//
//  CoreColumnLayout.swift
//  ColumnLayoutExample
//
//  Created by Majid Boudaoud on 01/03/2019.
//  Copyright © 2019 Majid Boudaoud. All rights reserved.
//

import UIKit

struct CLHorizontalLayoutCalculator {
    
    static func calculateHeaderAttributes(_ currentOffset: CGFloat, _ descriptor: CLLayoutDescriptor) -> CGRect {
        let xPosition = currentOffset + descriptor.insets.left
        let yPosition = descriptor.insets.top
        let width = descriptor.headerWidth
        let height = descriptor.availableHeight - descriptor.insets.top - descriptor.insets.bottom
        return CGRect(x: xPosition, y: yPosition, width: width, height: height)
    }
    
    static func calculateHeightValues(_ descriptor: CLLayoutDescriptor) -> CGFloat {
        let insets = descriptor.insets
        let lineSpacing = descriptor.lineSpacing
        let numberOfColumns = CGFloat(descriptor.numberOfColumns)
        let columnHeight = descriptor.availableHeight - insets.top - insets.bottom - ((numberOfColumns - 1) * lineSpacing)
        let cellHeight = columnHeight / numberOfColumns
        return cellHeight
    }
    
    static func calculateCellWidth(_ descriptor: CLLayoutDescriptor) -> [CGFloat] {
        var widthValues: [CGFloat] = []
        for index in 0..<descriptor.numberOfItems {
            let indexPath = IndexPath(item: index, section: descriptor.section)
            if let height = descriptor.delegate?.heightForCellAt(indexPath: indexPath) {
                widthValues.append(height)
            }
        }
        return widthValues
    }
    
    static func calculateHorizontalValues(_ currentOffset: CGFloat, _ descriptor: CLLayoutDescriptor, _ widthValues: [CGFloat]) -> [CGFloat] {
        let currentOffset = currentOffset + descriptor.interItemSpacing
        let xPositions = widthValues.enumerated().map { (offset, height) -> CGFloat in
            return computeValues(fromValue: currentOffset,
                                 lineSpacing: descriptor.interItemSpacing,
                                 index: offset,
                                 array: widthValues,
                                 numberOfColumns: descriptor.numberOfColumns)
        }
        return xPositions
    }
    
    static func calculateVerticalValues(_ descriptor: CLLayoutDescriptor, _ cellHeight: CGFloat) -> [CGFloat] {
        var yPositions: [CGFloat] = []
        for i in 0..<descriptor.numberOfColumns {
            let index = CGFloat(i)
            let verticalInsets: CGFloat = descriptor.insets.top + (index * descriptor.lineSpacing)
            let cellHeight: CGFloat = index * cellHeight
            let x = verticalInsets + cellHeight
            yPositions.append(x)
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

struct CLVerticalLayoutCalculator {
    
    static func calculateHeaderAttributes(descriptor: CLLayoutDescriptor, currentOffset: CGFloat) -> CGRect {
        let xPosition = descriptor.insets.left
        let yPosition = currentOffset + descriptor.insets.top
        let width = descriptor.availableWidth - descriptor.insets.left - descriptor.insets.right
        let height = descriptor.headerHeight
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
