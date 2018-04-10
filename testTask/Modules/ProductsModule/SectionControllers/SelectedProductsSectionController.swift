//
//  SelectedProductsSectionController.swift
//  testTask
//
//  Created by Yuriy T on 10.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import IGListKit

class SelectedProductsSectionController: ListSectionController {
    // MARK: - Private properties
    fileprivate var viewModel: SelectedProductViewModel!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension SelectedProductsSectionController {
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        
        return viewModel.getContainerSize((context.containerSize.width / 4))
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext else { return UICollectionViewCell() }
        let cell = context.dequeueReusableCell(withNibName: "SelectedProductCell", bundle: nil, for: self, at: index) as! SelectedProductCell
        cell.setup(with: viewModel)
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        viewModel = object as? SelectedProductViewModel
    }
}
