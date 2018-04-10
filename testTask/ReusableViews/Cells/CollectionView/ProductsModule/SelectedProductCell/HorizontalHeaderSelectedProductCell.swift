//
//  HorizontalHeaderSelectedProductCell.swift
//  testTask
//
//  Created by Yuriy T on 11.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import UIKit

class HorizontalHeaderSelectedProductCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var headerLabel: UILabel!

    // MARK: - Private properties
    fileprivate var viewModel: SelectedProductListHeaderViewModel!
    
    // MARK: - Configuring
    func setup(with viewModel: SelectedProductListHeaderViewModel) {
        self.viewModel = viewModel
        self.viewModel.dataUpdater = self
        headerLabel.attributedText = viewModel.headerTextAttributedString
    }
}

// MARK: - UsersListHeaderViewModelDataUpdater
extension HorizontalHeaderSelectedProductCell: SelectedProductListHeaderViewModelDataUpdater {
    func horizontalHeaderSelectedProductDidUpdate(_ viewModel: SelectedProductListHeaderViewModel) {
        setup(with: viewModel)
    }
}
