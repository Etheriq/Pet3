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
    @IBOutlet private weak var actualPriceLabel: UILabel!
    @IBOutlet private weak var oldPriceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var increaseAmounButton: UIButton!
    @IBOutlet private weak var decreaseAmountButton: UIButton!
    
    // MARK: - Private properties
    private var viewModel: FeatureViewModel?
    private let minAmount: Int = 0
    private let maxAmount: Int = 25
    private var currentAmount: Int = 0 {
        didSet {
            increaseAmounButton.isEnabled = currentAmount < maxAmount
            decreaseAmountButton.isEnabled = currentAmount > minAmount
            amountLabel.attributedText = String(format: "%i", currentAmount).styled(with: .bold)
        }
    }
    
    // MARK: - Actions
    @IBAction func increaseButtonAction(_ sender: UIButton) {
        currentAmount += 1
        viewModel?.amount = currentAmount
        viewModel?.incrementAmount()
    }
    
    @IBAction func decreaseButtonAction(_ sender: UIButton) {
        currentAmount -= 1
        viewModel?.amount = currentAmount
        viewModel?.decrementAmount()
    }

    // MARK: - Public functions
    func setup(with viewModel: FeatureViewModel) {
        self.viewModel = viewModel
        self.viewModel?.dataUpdater = self
        
        currentAmount = viewModel.amount
        actualPriceLabel.attributedText = "\(viewModel.featureActualPriceString) \(viewModel.featureCurrencyString)".styled(with: .bold)
        oldPriceLabel.attributedText = "\(viewModel.featureOldPriceString) \(viewModel.featureCurrencyString)".styled(with: .featureWithCrossOut, crossOut: true)
        descriptionLabel.attributedText = viewModel.featureDescriptionString.styled(with: .featureWithCrossOut)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
        currentAmount = 0
    }
}

extension FeatureCell: FeatureViewModelDataUpdater {
    func featureViewModelDidUpdate(_ viewModel: FeatureViewModel) {
        setup(with: viewModel)
    }
}
