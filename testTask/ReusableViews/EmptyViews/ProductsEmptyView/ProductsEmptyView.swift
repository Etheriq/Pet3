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
    @IBOutlet private weak var generateButton: UIButton!
    
    // MARK: - Public properties
    var onGenerateAction: (() -> ())?
    
    // MARK: - Actions
    @IBAction func generateAction(_ sender: UIButton) {
        onGenerateAction?()
    }
    
    // MARK: - Public functions
    func setup(with title: NSAttributedString) {
        generateButton.setAttributedTitle(title, for: .normal)
    }
}
