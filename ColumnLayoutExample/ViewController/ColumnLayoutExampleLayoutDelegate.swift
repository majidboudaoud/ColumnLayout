//
//  ColumnLayoutExampleLayoutDelegate.swift
//  ColumnLayoutExample
//
//  Created by Majid Boudaoud on 24/03/2020.
//  Copyright © 2020 Majid Boudaoud. All rights reserved.
//

import UIKit
import ColumnLayout

class ColumnLayoutExampleLayoutDelegate: ColumnLayoutDelegate {
    
    func numberOfColumnsFor(section: Int) -> Int {
        let section = ColumnLayoutExampleSectionType.allCases[section]
        return section.numberOfColumns
    }
    
    func referenceHeightForHeaderInSection(section: Int) -> CGFloat {
        return 90
    }
    
    func heightForCellAt(indexPath: IndexPath) -> CGFloat { 200 }
    
    func minimumInteritemSpacingForSection(section: Int) -> CGFloat { 8 }
    
    func minimumLineSpacingForSection(section: Int) -> CGFloat { 8 }
    
    func insetForSectionAtIndex(section: Int) -> UIEdgeInsets { .init(top: 0, left: 8, bottom: 0, right: 8) }
}
