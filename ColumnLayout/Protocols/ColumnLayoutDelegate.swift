//
//  ColumnLayoutDelegate.swift
//  ColumnLayoutExample
//
//  Created by Majid Boudaoud on 30/03/2019.
//  Copyright © 2019 Majid Boudaoud. All rights reserved.
//

import UIKit

public protocol ColumnLayoutDelegate: class {
    func numberOfColumnsFor(section: Int) -> Int
    func heightForCellAt(indexPath: IndexPath) -> CGFloat
    func referenceHeightForHeaderInSection(section: Int) -> CGFloat
    func insetForSectionAtIndex(section: Int) -> UIEdgeInsets
    func minimumInteritemSpacingForSection(section: Int) -> CGFloat
    func minimumLineSpacingForSection(section: Int) -> CGFloat
}

public extension ColumnLayoutDelegate {
    
    func insetForSectionAtIndex(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func heightForCellAt(indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfColumnsFor(section: Int) -> Int {
        return 1
    }
    
    func minimumInteritemSpacingForSection(section: Int) -> CGFloat {
        return 10.0
    }
    
    func minimumLineSpacingForSection(section: Int) -> CGFloat {
        return 10.0
    }
    
    func referenceHeightForHeaderInSection(section: Int) -> CGFloat {
        return 30.0
    }
}
