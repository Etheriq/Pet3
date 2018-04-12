//
//  SelectedProductListViewModel.swift
//  testTask
//
//  Created by Yuriy T on 10.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import IGListKit

protocol SelectedProductListViewModelProtocol: class {
    var objectsToDisplay: [SelectedProductViewModel] { get }
    var uniqueId: String { get }
    
    func addProductViewModel(_ viewModel: ProductViewModel)
    func removeProductViewModel(_ viewModel: SelectedProductViewModel)
}

protocol SelectedProductListViewModelDelegate: class {
    func selectedProductViewModelDidDeselected()
}

protocol SelectedProductListViewModelDataUpdater: class {
    func selectedProductListViewModelDidUpdated()
}

class SelectedProductListViewModel {
    
    // MARK: - Public properties
    weak var delegate: SelectedProductListViewModelDelegate?
    weak var dataUpdater: SelectedProductListViewModelDataUpdater?
    
    // MARK: - Private properties
    fileprivate let unique = UUID().uuidString
    fileprivate var selectedViewModels: [SelectedProductViewModel] = []
    
    // MARK: - Private functions
    fileprivate func getIndex(of viewModel: SelectedProductViewModel) -> Int? {
        let index = selectedViewModels.index { indexedViewModel -> Bool in
            return viewModel.uniqueId == indexedViewModel.uniqueId
        }
        return index
    }
    
    fileprivate func removeSelectedViewModel(_ viewModel: SelectedProductViewModel) {
        if let index = getIndex(of: viewModel) {
            selectedViewModels.remove(at: index)
            viewModel.userDidDeselectProductButton()
            delegate?.selectedProductViewModelDidDeselected()
            dataUpdater?.selectedProductListViewModelDidUpdated()
        }
    }
}

// MARK: - ListDiffable
extension SelectedProductListViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return uniqueId as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? SelectedProductListViewModel {
            return object.uniqueId == uniqueId
        } else {
            return false
        }
    }
}

// MARK: - SelectedProductListViewModelProtocol
extension SelectedProductListViewModel: SelectedProductListViewModelProtocol {
    var uniqueId: String {
        return unique
    }
    
    var objectsToDisplay: [SelectedProductViewModel] {
        return selectedViewModels
    }
    
    func addProductViewModel(_ viewModel: ProductViewModel) {
        let selectedViewModel = SelectedProductViewModel(viewModel)
        selectedViewModel.delegate = self
        selectedViewModels.append(selectedViewModel)
        dataUpdater?.selectedProductListViewModelDidUpdated()
    }
    
    func removeProductViewModel(_ viewModel: SelectedProductViewModel) {
        removeSelectedViewModel(viewModel)
    }
}

// MARK: - SelectedProductViewModelDelegate
extension SelectedProductListViewModel: SelectedProductViewModelDelegate {
    func selectedproductViewModelDidDeselected(_ viewModel: SelectedProductViewModel) {
        removeSelectedViewModel(viewModel)
    }
}
