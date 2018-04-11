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
    var amount: Int { get }
    var featureCurrencyString: String { get }
    var featureActualPriceString: String { get }
    var featureOldPriceString: String { get }
    var featureDescriptionString: String { get }
    
    func getContainerSize(_ contextWidth: CGFloat) -> CGSize
}

protocol FeatureViewModelDelegate: class {
    func featureViewModelDidUpdate(_ viewModel: FeatureViewModel)
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
    var uniqueId: String {
        return unique
    }
    
    var amount: Int {
        return featureAmount
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
    
    func getContainerSize(_ contextWidth: CGFloat) -> CGSize {
        let width: CGFloat = contextWidth - 20
        let actualPriceHeight = "\(featureActualPriceString) \(featureCurrencyString)".styled(with: .regular).height(withWidth: width, andNumberOfLines: 1)
        let oldPriceHeight = "\(featureOldPriceString) \(featureCurrencyString)".styled(with: .regular).height(withWidth: width, andNumberOfLines: 1)
        let featureDescriptionHeight = featureDescriptionString.styled(with: .regular).height(withWidth: width, andNumberOfLines: 0)
        
        let totalHeight = actualPriceHeight + oldPriceHeight + featureDescriptionHeight + 90
        
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
