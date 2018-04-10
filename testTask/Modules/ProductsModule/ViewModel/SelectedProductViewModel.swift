//
//  SelectedProductViewModel.swift
//  testTask
//
//  Created by Yuriy T on 10.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import IGListKit

protocol SelectedProductViewModelProtocol: class {
    var uniqueId: String { get }
    var imagePath: String { get }
    var productDescriptionString: NSAttributedString { get }
    
    func userDidDeselectProductButton()
    func getContainerSize(_ contextWidth: CGFloat) -> CGSize
}

protocol SelectedProductViewModelDelegate: class {
    func selectedproductViewModelDidDeselected(_ viewModel: SelectedProductViewModel)
}

protocol SelectedProductViewModelDataUpdater: class {
    func selectedproductViewModelDidDeselected(_ viewModel: SelectedProductViewModel)
}

class SelectedProductViewModel {
    
    // MARK: - Public properties
    weak var delegate: SelectedProductViewModelDelegate?
    weak var dataUpdater: SelectedProductViewModelDataUpdater?
    
    // MARK: - Private properties
    fileprivate let unique = UUID().uuidString
    fileprivate let productViewModel: ProductViewModel
    
    // MARK: - Initialization
    init(_ productViewModel: ProductViewModel) {
        self.productViewModel = productViewModel
    }
}

// MARK: - SelectedProductViewModelProtocol
extension SelectedProductViewModel: SelectedProductViewModelProtocol {
    var uniqueId: String {
        return unique
    }
    
    var imagePath: String {
        return productViewModel.imagePath
    }
    
    var productDescriptionString: NSAttributedString {
        return productViewModel.productDescriptionString
    }
    
    func userDidDeselectProductButton() {
        productViewModel.selected = false
        delegate?.selectedproductViewModelDidDeselected(self)
    }
    
    func getContainerSize(_ contextWidth: CGFloat) -> CGSize {
        let width: CGFloat = contextWidth - 20
        let productDescriptionHeight = productDescriptionString.height(withWidth: width)
        // width = image height
        let containerTotalHeight = width + productDescriptionHeight + 20
        
        return CGSize(width: contextWidth, height: containerTotalHeight)
    }
}

// MARK: - ListDiffable
extension SelectedProductViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return uniqueId as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? SelectedProductViewModel {
            return object.uniqueId == uniqueId
        } else {
            return false
        }
    }
}
