//
//  SelectedProductCell.swift
//  testTask
//
//  Created by Yuriy T on 10.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import UIKit

class SelectedProductCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Private properties
    private var viewModel: SelectedProductViewModel!

    // MARK: - Public functions
    func setup(with viewModel: SelectedProductViewModel) {
        self.viewModel = viewModel
        self.viewModel.dataUpdater = self
        if let url = URL(string: viewModel.imagePath) {
            imageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.2))])
        }
        descriptionLabel.attributedText = viewModel.productDescriptionString
    }
}

extension SelectedProductCell: SelectedProductViewModelDataUpdater {
    func selectedproductViewModelDidDeselected(_ viewModel: SelectedProductViewModel) {
        setup(with: viewModel)
    }
}
