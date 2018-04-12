//
//  ProductListViewModel.swift
//  testTask
//
//  Created by Yuriy T on 09.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import IGListKit

protocol ProductListViewModelProtocol: class {
    var objectsToDisplay: [ListDiffable] { get }
    func generateProductViewModels()
    var uniqueId: String { get }
}

protocol ProductListViewModelDelegate: class {
    func productListViewModelDidUpdate(_ viewModelList: ProductListViewModel, andWithViewModel: ProductViewModel)
}

class ProductListViewModel {
    
    // MARK: - Public properties
    weak var delegate: ProductListViewModelDelegate?
    
    // MARK: - Private properties
    fileprivate var viewModels: [ProductViewModel] = []
    fileprivate let unique = UUID().uuidString
    
    // MARK: - Private functions
    fileprivate func generateViewModels() {
        for _ in 1...30 {
            let product = ProductModel.random()
            let viewModel = ProductViewModel(product)
            viewModel.delegate = self
            viewModels.append(viewModel)
        }
    }
}

// MARK: - ProductListViewModelProtocol
extension ProductListViewModel: ProductListViewModelProtocol {
    var objectsToDisplay: [ListDiffable] {
        return viewModels
    }
    
    var uniqueId: String {
        return unique
    }
    
    func generateProductViewModels() {
        generateViewModels()
    }
}

// MARK: - ProductViewModelDelegate
extension ProductListViewModel: ProductViewModelDelegate {
    func productViewModelDidSelected(_ viewModel: ProductViewModel) {
        delegate?.productListViewModelDidUpdate(self, andWithViewModel: viewModel)
    }
}

// MARK: - ListDiffable
extension ProductListViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return uniqueId as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? ProductListViewModel {
            return object.uniqueId == uniqueId
        } else {
            return false
        }
    }
}
