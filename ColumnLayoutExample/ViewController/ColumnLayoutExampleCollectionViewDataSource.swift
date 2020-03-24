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
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ColumnLayoutExampleSectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = .red
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.layer.masksToBounds = true
        return cell
    }
}
