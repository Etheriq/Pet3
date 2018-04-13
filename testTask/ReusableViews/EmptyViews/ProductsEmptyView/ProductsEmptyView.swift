//
//  ProductsEmptyView.swift
//  testTask
//
//  Created by Yuriy T on 09.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import UIKit

class ProductsEmptyView: UIView {

    // MARK: - Outlets
    @IBOutlet private weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = Color.SharedColors.featureBackground
    }
    
    // MARK: - Public functions
    func setup(with infoText: NSAttributedString) {
        infoLabel.attributedText = infoText
    }
}
