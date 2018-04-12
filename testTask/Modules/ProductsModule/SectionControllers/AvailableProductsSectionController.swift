//
//  AvailableProductsSectionController.swift
//  testTask
//
//  Created by Yuriy T on 09.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import IGListKit

class AvailableProductsSectionController: ListSectionController {
    // MARK: - Private properties
    fileprivate var viewModel: ProductListViewModel!
}

extension AvailableProductsSectionController {
    override func numberOfItems() -> Int {
        return viewModel.objectsToDisplay.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        
        let _productViewModel = viewModel.objectsToDisplay[index] as? ProductViewModel
        if let productViewModel = _productViewModel {
            return productViewModel.getContainerSize((context.containerSize.width / 2))
        }
        
        return .zero
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext, let productViewModel = viewModel.objectsToDisplay[index] as? ProductViewModel else { return UICollectionViewCell() }
        let cell = context.dequeueReusableCell(withNibName: "ProductCell", bundle: nil, for: self, at: index) as! ProductCell
        cell.setup(with: productViewModel)
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        viewModel = object as? ProductListViewModel
    }
}
