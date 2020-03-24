//
//  ColumnLayoutExampleView.swift
//  ColumnLayoutExample
//
//  Created by Majid Boudaoud on 24/03/2020.
//  Copyright © 2020 Majid Boudaoud. All rights reserved.
//

import UIKit
import ColumnLayout

class ColumnLayoutExampleView: UIView {
    
    private let columnLayoutDelegate = ColumnLayoutExampleLayoutDelegate()
    private let dataSource = ColumnLayoutExampleCollectionViewDataSource()
    
    private lazy var columnLayout: ColumnLayout = {
        let columnLayout = ColumnLayout()
        columnLayout.delegate = columnLayoutDelegate
        columnLayout.effects = [CLStretchyEffect.self]
        return columnLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: columnLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dataSource.registerCellsFor(collectionView: collectionView)
        collectionView.dataSource = dataSource
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(collectionView)
    }
}
