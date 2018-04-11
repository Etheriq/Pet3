//
//  FeatureListViewModel.swift
//  testTask
//
//  Created by Yuriy T on 12.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import IGListKit

protocol FeatureListViewModelProtocol: class {
    var objectsToDisplay: [ListDiffable] { get }
    var uniqueId: String { get }
    
    func generateFeatureViewModels()
}

protocol FeatureListViewModelDelegate: class {
    func featureListViewModelDidUpdate(_ listViewModel: FeatureListViewModel, andWithViewModel viewModel: FeatureViewModel)
}

class FeatureListViewModel {
    // MARK: - Public properties
    weak var delegate: FeatureListViewModelDelegate?
    
    // MARK: - Private properties
    fileprivate let unique = UUID().uuidString
    fileprivate var viewModels: [FeatureViewModel] = []
    
    // MARK: - Private functions
    fileprivate func generateViewModels() {
        for _ in 1...10 {
            let feature = FeatureModel.randomFeature()
            let viewModel = FeatureViewModel(feature)
            viewModel.delegate = self
            viewModels.append(viewModel)
        }
    }
}

// MARK: - FeatureViewModelProtocol
extension FeatureListViewModel: FeatureListViewModelProtocol {
    var uniqueId: String {
        return unique
    }
    
    var objectsToDisplay: [ListDiffable] {
        return viewModels
    }
    
    func generateFeatureViewModels() {
        generateViewModels()
    }
}

// MARK: - FeatureViewModelDelegate
extension FeatureListViewModel: FeatureViewModelDelegate {
    func featureViewModelDidUpdate(_ viewModel: FeatureViewModel) {
        delegate?.featureListViewModelDidUpdate(self, andWithViewModel: viewModel)
    }
}

// MARK: - ListDiffable
extension FeatureListViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return uniqueId as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? FeatureListViewModel {
            return object.uniqueId == uniqueId
        } else {
            return false
        }
    }
}
