//
//  FeatureCell.swift
//  testTask
//
//  Created by Yuriy T on 12.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import UIKit

class FeatureCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var actualPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    
    // MARK: - Private properties
    private var viewModel: FeatureViewModel!

    // MARK: - Public functions
    func setup(with viewModel: FeatureViewModel) {
        self.viewModel = viewModel
        self.viewModel.dataUpdater = self
        
        actualPriceLabel.attributedText = "\(viewModel.featureActualPriceString) \(viewModel.featureCurrencyString)".styled(with: .regular)
        oldPriceLabel.attributedText = "\(viewModel.featureOldPriceString) \(viewModel.featureCurrencyString)".styled(with: .regular)
    }
}

extension FeatureCell: FeatureViewModelDataUpdater {
    func featureViewModelDidUpdate(_ viewModel: FeatureViewModel) {
        setup(with: viewModel)
    }
}
