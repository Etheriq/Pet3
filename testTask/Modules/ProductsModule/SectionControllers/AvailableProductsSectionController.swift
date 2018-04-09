//
//  AvailableProductsSectionController.swift
//  testTask
//
//  Created by Yuriy T on 09.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import IGListKit

class AvailableProductsSectionController: ListSectionController {
    fileprivate var viewModel: ProductViewModel!
}

extension AvailableProductsSectionController {
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        
        return viewModel.getContainerSize((context.containerSize.width / 2))
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext else { return UICollectionViewCell() }
        
        let cell = context.dequeueReusableCell(withNibName: "ProductCell", bundle: nil, for: self, at: index) as! ProductCell
        cell.setup(with: viewModel)
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        viewModel = object as? ProductViewModel
    }
}
