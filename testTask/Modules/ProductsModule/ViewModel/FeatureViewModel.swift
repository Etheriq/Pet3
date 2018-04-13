//
//  FeatureViewModel.swift
//  testTask
//
//  Created by Yuriy T on 12.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import IGListKit

protocol FeatureViewModelProtocol: class {
    var uniqueId: String { get }
    var amount: Int { set get }
    var featureCurrencyString: String { get }
    var featureActualPriceString: String { get }
    var featureActualPriceInt: Int { get }
    var featureOldPriceString: String { get }
    var featureDescriptionString: String { get }
    
    func incrementAmount()
    func decrementAmount()
    
    func getContainerSize(_ contextWidth: CGFloat) -> CGSize
}

protocol FeatureViewModelDelegate: class {
    func featureViewModelDidUpdate(_ viewModel: FeatureViewModel)
    func featureWasIncrease(_ viewModel: FeatureViewModel)
    func featureWasDecrease(_ viewModel: FeatureViewModel)
}

protocol FeatureViewModelDataUpdater: class {
    func featureViewModelDidUpdate(_ viewModel: FeatureViewModel)
}

class FeatureViewModel {
    
    // MARK: - Public properties
    weak var delegate: FeatureViewModelDelegate?
    weak var dataUpdater: FeatureViewModelDataUpdater?
    
    // MARK: - Private properties
    fileprivate var featureAmount: Int = 0
    fileprivate let unique = UUID().uuidString
    fileprivate let feature: FeatureModel
    
    // MARK: - Initialization
    init(_ feature: FeatureModel) {
        self.feature = feature
    }
}

// MARK: - FeatureViewModelProtocol
extension FeatureViewModel: FeatureViewModelProtocol {
    var amount: Int {
        get {
            return featureAmount
        }
        set {
            featureAmount = newValue
        }
    }
    
    var featureActualPriceInt: Int {
        return feature.actualPrice
    }
    
    var uniqueId: String {
        return unique
    }
    
    var featureCurrencyString: String {
        return feature.currency
    }
    
    var featureActualPriceString: String {
        return String(format: "%i", feature.actualPrice)
    }
    
    var featureOldPriceString: String {
        return String(format: "%i", feature.oldPrice)
    }
    
    var featureDescriptionString: String {
        return feature.featureDescription
    }
    
    func incrementAmount() {
        delegate?.featureWasIncrease(self)
    }
    func decrementAmount() {
        delegate?.featureWasDecrease(self)
    }
    
    func getContainerSize(_ contextWidth: CGFloat) -> CGSize {
        let width: CGFloat = contextWidth - 40
        let actualPriceHeight = "\(featureActualPriceString) \(featureCurrencyString)".styled(with: .regular).height(withWidth: width, andNumberOfLines: 1)
        let oldPriceHeight = "\(featureOldPriceString) \(featureCurrencyString)".styled(with: .regular).height(withWidth: width, andNumberOfLines: 1)
        let featureDescriptionHeight = featureDescriptionString.styled(with: .regular).height(withWidth: width, andNumberOfLines: 0)
        
        let totalHeight = actualPriceHeight + oldPriceHeight + featureDescriptionHeight + 122
        
        return CGSize(width: contextWidth, height: totalHeight)
    }
}

// MARK: - ListDiffable
extension FeatureViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return uniqueId as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? FeatureViewModel {
            return object.uniqueId == uniqueId
        } else {
            return false
        }
    }
}
