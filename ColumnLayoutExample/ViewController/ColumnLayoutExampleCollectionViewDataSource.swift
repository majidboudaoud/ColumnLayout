//
//  ColumnLayoutExampleCollectionViewDataSource.swift
//  ColumnLayoutExample
//
//  Created by Majid Boudaoud on 24/03/2020.
//  Copyright © 2020 Majid Boudaoud. All rights reserved.
//

import UIKit

class ColumnLayoutExampleCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func registerCellsFor(collectionView: UICollectionView) {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ColumnLayoutExampleSectionType.allCases.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = .red
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.layer.masksToBounds = true
        return cell
    }
}
