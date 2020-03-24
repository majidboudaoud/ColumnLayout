//
//  UICollectionView+ExtensionTest.swift
//  ColumnLayoutTests
//
//  Created by Majid Boudaoud on 24/03/2020.
//  Copyright © 2020 Majid Boudaoud. All rights reserved.
//

import UIKit
import ColumnLayout

extension UICollectionView {
    static func createMock(x: CGFloat = 0,
                           y: CGFloat = 0,
                           width: CGFloat = 300,
                           height: CGFloat = 800,
                           layout: UICollectionViewLayout = ColumnLayout()) -> UICollectionView {
        let frame: CGRect = .init(x: x, y: y, width: width, height: height)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = collectionView
        return collectionView
    }
}

extension UICollectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 38
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

