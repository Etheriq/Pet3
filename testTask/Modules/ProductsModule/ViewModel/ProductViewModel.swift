//
//  ProductViewModel.swift
//  testTask
//
//  Created by Yuriy T on 09.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import IGListKit

protocol ProductViewModelProtocol: class {
    var uniqueId: String { get }
    var state: Bool { get }
    var imagePath: String { get }
    var productCurrencyString: NSAttributedString { get }
    var productPriceString: NSAttributedString { get }
    var productDescriptionString: String { get }
    
    func userDidSelectProductButton()
    func getContainerSize(_ contextWidth: CGFloat) -> CGSize
}

protocol ProductViewModelDelegate: class {
    func productViewModelDidSelected(_ viewModel: ProductViewModel)
}

protocol ProductViewModelDataUpdater: class {
    func productViewModelDidSelected(_ viewModel: ProductViewModel)
}

class ProductViewModel {
    
    // MARK: - Public properties
    var selected = false
    weak var delegate: ProductViewModelDelegate?
    weak var dataUpdater: ProductViewModelDataUpdater?
    
    // MARK: - Private properties
    fileprivate let unique = UUID().uuidString
    fileprivate let product: ProductModel
    
    // MARK: - Initialization
    init(_ product: ProductModel) {
        self.product = product
    }
}

// MARK: - ProductViewModelProtocol
extension ProductViewModel: ProductViewModelProtocol {
    var uniqueId: String {
        return unique
    }
    
    var state: Bool {
        return selected
    }
    
    var imagePath: String {
        return product.imagePath
    }
    
    var productCurrencyString: NSAttributedString {
        return product.currency.styled(with: .bold)
    }
    
    var productPriceString: NSAttributedString {
        return  String(format: "%i", product.price).styled(with: .bold)
    }
    
    var productDescriptionString: String {
        return product.productDescription
    }
    
    func userDidSelectProductButton() {
        selected = !selected
        dataUpdater?.productViewModelDidSelected(self)
        delegate?.productViewModelDidSelected(self)
    }
    
    func getContainerSize(_ contextWidth: CGFloat) -> CGSize {
        let width: CGFloat = contextWidth - 20
        let productDescriptionHeight = productDescriptionString.styled(with: .regular).height(withWidth: width, andNumberOfLines: 2)
        let priceHeight = productPriceString.height(withWidth: width)
        // width = image height
        let containerTotalHeight = width + priceHeight + productDescriptionHeight + 40
        
        return CGSize(width: contextWidth, height: containerTotalHeight)
    }
}

// MARK: - ListDiffable
extension ProductViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return uniqueId as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? ProductViewModel {
            return object.uniqueId == uniqueId
        } else {
            return false
        }
    }
}
