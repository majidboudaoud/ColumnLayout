//
//  ColumnLayoutTests.swift
//  ColumnLayoutTests
//
//  Created by Majid Boudaoud on 30/03/2019.
//  Copyright © 2019 Majid Boudaoud. All rights reserved.
//

import XCTest
@testable import ColumnLayout

class ColumnLayoutTests: XCTestCase {
    
    private var collectionView: UICollectionView?
    
    override func setUp() {
        super.setUp()
        collectionView = nil
    }

    func testWithTwoColumnsNoInset() {
        let columnLayout = ColumnLayout.createMock(numberOfColumns: 2,
                                                   heightForCell: 50)
        self.collectionView = UICollectionView.createMock(width: 300,
                                                          height: 800,
                                                          layout: columnLayout)
        columnLayout.prepare()
        let attributes = columnLayout.layoutAttributesForItem(at: .init(row: 0, section: 0))
        XCTAssertEqual(attributes?.bounds, CGRect(x: 0, y: 0, width: 150, height: 50))
    }
    
    func testWithTwoColumnsWithInsets() {
        let columnLayout = ColumnLayout.createMock(numberOfColumns: 2,
                                                   heightForCell: 50,
                                                   insetForSection: .init(top: 0, left: 40, bottom: 0, right: 40))
        self.collectionView = UICollectionView.createMock(width: 300, height: 800, layout: columnLayout)
        columnLayout.prepare()
        let attributes = columnLayout.layoutAttributesForItem(at: .init(row: 0, section: 0))
        XCTAssertEqual(attributes?.frame, CGRect(x: 40, y: 0, width: 110, height: 50))
    }
    
    func testWithTwoColumnsWithInsetsAndInteritemSpacing() {
        let columnLayout = ColumnLayout.createMock(numberOfColumns: 2,
                                                   heightForCell: 50,
                                                   minimumInteritemSpacing: 8,
                                                   insetForSection: .init(top: 0, left: 40, bottom: 0, right: 40))
        self.collectionView = UICollectionView.createMock(width: 300, height: 800, layout: columnLayout)
        columnLayout.prepare()
        let attributes = columnLayout.layoutAttributesForItem(at: .init(row: 0, section: 0))
        XCTAssertEqual(attributes?.frame, CGRect(x: 40, y: 0, width: 106, height: 50))
    }
    
    func testWithTwoColumnsWithInsetsAndInteritemSpacingAndLineSpacing() {
        let columnLayout = ColumnLayout.createMock(numberOfColumns: 2,
                                                   heightForCell: 50,
                                                   minimumInteritemSpacing: 8,
                                                   minimumLineSpacingForSection: 8,
                                                   insetForSection: .init(top: 0, left: 40, bottom: 0, right: 40))
        self.collectionView = UICollectionView.createMock(width: 300, height: 800, layout: columnLayout)
        columnLayout.prepare()
        let attributes = columnLayout.layoutAttributesForItem(at: .init(row: 2, section: 0))
        XCTAssertEqual(attributes?.frame, CGRect(x: 40, y: 66, width: 106, height: 50))
    }
    
    func testWithTwoColumnsAndHeaderWithInsetsAndInteritemSpacingAndLineSpacing() {
        let columnLayout = ColumnLayout.createMock(numberOfColumns: 2,
                                                   heightForCell: 50,
                                                   minimumInteritemSpacing: 8,
                                                   minimumLineSpacingForSection: 8,
                                                   referenceHeightForHeader: 120,
                                                   insetForSection: .init(top: 0, left: 40, bottom: 0, right: 40))
        self.collectionView = UICollectionView.createMock(width: 300, height: 800, layout: columnLayout)
        columnLayout.prepare()
        let attributes = columnLayout.layoutAttributesForItem(at: .init(row: 0, section: 0))
        XCTAssertEqual(attributes?.frame, CGRect(x: 40, y: 128, width: 106, height: 50))
    }
}
