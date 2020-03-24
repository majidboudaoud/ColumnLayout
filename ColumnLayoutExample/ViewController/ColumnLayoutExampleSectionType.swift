//
//  ColumnLayoutExampleSectionType.swift
//  ColumnLayoutExample
//
//  Created by Majid Boudaoud on 24/03/2020.
//  Copyright © 2020 Majid Boudaoud. All rights reserved.
//

import Foundation

enum ColumnLayoutExampleSectionType: Int, CaseIterable {
    case threeColumns
    case twoColumns
    case fourColumns
    
    var numberOfColumns: Int {
        switch self {
        case .threeColumns:
            return 3
        case .twoColumns:
            return 2
        case .fourColumns:
            return 4
        }
    }
}
