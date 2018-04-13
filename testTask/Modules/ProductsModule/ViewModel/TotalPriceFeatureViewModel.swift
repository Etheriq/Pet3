//
//  TotalPriceFeatureViewModel.swift
//  testTask
//
//  Created by Yuriy T on 13.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import Foundation

protocol TotalPriceFeatureViewModelProtocol: class {
    var totalPrice: Int { get }
    var currency: String { get }
    
    func increasePrice(_ newPrice: Int)
    func decreasePrice(_ newPrice: Int)
    func updateCurrency(_ newCurrency: String)
}

protocol TotalPriceFeatureViewModelDataUpdater: class {
    func totalPriceAndCurrencyWasUpdated(_ viewModel: TotalPriceFeatureViewModel)
}

class TotalPriceFeatureViewModel {
    
    // MARK: - Public properties
    weak var dataUpdater: TotalPriceFeatureViewModelDataUpdater?
    
    // MARK: - Private properties
    fileprivate var currentPrice: Int = 0
    fileprivate var currentCurrency: String = ""
}

// MARK: - TotalPriceFeatureViewModelProtocol
extension TotalPriceFeatureViewModel: TotalPriceFeatureViewModelProtocol {
    var totalPrice: Int {
        return currentPrice
    }
    
    var currency: String {
        return currentCurrency
    }
    
    func increasePrice(_ newPrice: Int) {
        currentPrice = currentPrice + newPrice
    }
    
    func decreasePrice(_ newPrice: Int) {
        currentPrice = currentPrice - newPrice
    }

    func updateCurrency(_ newCurrency: String) {
        currentCurrency = newCurrency
        dataUpdater?.totalPriceAndCurrencyWasUpdated(self)
    }
}
