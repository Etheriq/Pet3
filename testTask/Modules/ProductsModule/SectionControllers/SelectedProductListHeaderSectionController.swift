//
//  SelectedProductListHeaderSectionController.swift
//  testTask
//
//  Created by Yuriy T on 11.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import IGListKit

class SelectedProductListHeaderSectionController: ListSectionController {
    // MARK: - Private properties
    fileprivate var viewModel: SelectedProductListHeaderViewModel!
}

extension SelectedProductListHeaderSectionController {
    override func numberOfItems() -> Int {
        return 1
    }
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        return viewModel.getContainerSize(context.containerSize.width)
    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext else { return UICollectionViewCell() }
        let cell = context.dequeueReusableCell(withNibName: "HorizontalHeaderSelectedProductCell", bundle: nil, for: self, at: index) as! HorizontalHeaderSelectedProductCell
        cell.setup(with: viewModel)
        return cell
    }
    override func didUpdate(to object: Any) {
        viewModel = object as? SelectedProductListHeaderViewModel
    }
}
