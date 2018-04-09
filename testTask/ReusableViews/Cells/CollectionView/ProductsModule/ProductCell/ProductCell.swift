//
//  ProductCell.swift
//  testTask
//
//  Created by Yuriy T on 09.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var selectButton: UIButton!
    @IBOutlet private weak var currencyLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Private properties
    private var viewModel: ProductViewModel!
    private lazy var placeholderImage = UIImage(named: "placeholder")
    
    // MARK: - Actions
    @IBAction func selectAction(_ sender: UIButton) {
        viewModel.userDidSelectProductButton()
    }
    
    // MARK: - Private functions
    
    // MARK: - Public functions
    func setup(with viewModel: ProductViewModel) {
        self.viewModel = viewModel
        self.viewModel.dataUpdater = self
        
        if let url = URL(string: viewModel.imagePath) {
            imageView.kf.setImage(with: url, placeholder: placeholderImage, options: [.transition(.fade(0.2))])
        }
        selectButton.isSelected = viewModel.state
        currencyLabel.attributedText = viewModel.productCurrencyString
        priceLabel.attributedText = viewModel.productPriceString
        descriptionLabel.attributedText = viewModel.productDescriptionString
    }
}

// MARK: - ProductViewModelDataUpdater
extension ProductCell: ProductViewModelDataUpdater {
    func productViewModelDidSelected(_ viewModel: ProductViewModel) {
        setup(with: viewModel)
    }
}
