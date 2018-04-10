//
//  HorizontalSelectedProductCell.swift
//  testTask
//
//  Created by Yuriy T on 10.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import UIKit
import IGListKit

class HorizontalSelectedProductCell: UICollectionViewCell {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView =  UICollectionView(frame: .zero,
                                               collectionViewLayout: layout)

        collectionView.backgroundColor = Color.SharedColors.lightGray
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = true
        self.contentView.addSubview(collectionView)
        
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.frame
    }
}
