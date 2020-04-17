//
//  ColumnLayout+ExtensionsTest.swift
//  ColumnLayoutTests
//
//  Created by Majid Boudaoud on 24/03/2020.
//  Copyright © 2020 Majid Boudaoud. All rights reserved.
//

import UIKit
import ColumnLayout

private var _columnLayoutDelegate: ColumnLayoutDelegate? = nil

extension ColumnLayout {
    static func createMock(numberOfColumns: Int = 1,
                           heightForCell: CGFloat = 30.0,
                           minimumInteritemSpacing: CGFloat = 0,
                           minimumLineSpacingForSection: CGFloat = 0,
                           referenceHeightForHeader: CGFloat = 0,
                           insetForSection: UIEdgeInsets = .zero) -> ColumnLayout {
        let columnLayout = ColumnLayout()
        let columnLayoutDelegate = ColumnLayoutMock(numberOfColumns: numberOfColumns,
                                                    heightForCell: heightForCell,
                                                    minimumInteritemSpacing: minimumInteritemSpacing,
                                                    minimumLineSpacingForSection: minimumLineSpacingForSection,
                                                    referenceHeightForHeader: referenceHeightForHeader,
                                                    insetForSection: insetForSection)
        columnLayout.delegate = columnLayoutDelegate
        _columnLayoutDelegate = columnLayoutDelegate
        return columnLayout
    }
}

class ColumnLayoutMock: ColumnLayoutDelegate {
    
    private let numberOfColumns: Int
    private let heightForCell: CGFloat
    private let minimumInteritemSpacing: CGFloat
    private let minimumLineSpacingForSection: CGFloat
    private let referenceHeightForHeader: CGFloat
    private let insetForSection: UIEdgeInsets
    
    init(numberOfColumns: Int,
         heightForCell: CGFloat,
         minimumInteritemSpacing: CGFloat,
         minimumLineSpacingForSection: CGFloat,
         referenceHeightForHeader: CGFloat,
         insetForSection: UIEdgeInsets) {
        self.numberOfColumns = numberOfColumns
        self.heightForCell = heightForCell
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacingForSection = minimumLineSpacingForSection
        self.referenceHeightForHeader = referenceHeightForHeader
        self.insetForSection = insetForSection
    }
    
    func insetForSectionAtIndex(section: Int) -> UIEdgeInsets {
        return self.insetForSection
    }
    
    func heightForCellAt(indexPath: IndexPath) -> CGFloat {
        return self.heightForCell
    }
    
    func numberOfColumnsFor(section: Int) -> Int {
        return self.numberOfColumns
    }
    
    func minimumInteritemSpacingForSection(section: Int) -> CGFloat {
        return self.minimumInteritemSpacing
    }
    
    func minimumLineSpacingForSection(section: Int) -> CGFloat {
        return self.minimumLineSpacingForSection
    }
    
    func referenceHeightForHeaderInSection(section: Int) -> CGFloat {
        return self.referenceHeightForHeader
    }
}
