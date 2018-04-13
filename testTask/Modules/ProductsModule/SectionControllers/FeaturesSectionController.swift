//
//  FeaturesSectionController.swift
//  testTask
//
//  Created by Yuriy T on 12.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import IGListKit

class FeaturesSectionController: ListSectionController {
    // MARK: - Private properties
    fileprivate var viewModel: FeatureListViewModel!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
}

extension FeaturesSectionController {
    override func numberOfItems() -> Int {
        return viewModel.objectsToDisplay.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        
        let _featureViewModel = viewModel.objectsToDisplay[index] as? FeatureViewModelProtocol
        if let featureViewModel = _featureViewModel {
            return featureViewModel.getContainerSize(context.containerSize.width)
        }
        
        return .zero
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext, let featureViewModel = viewModel.objectsToDisplay[index] as? FeatureViewModel else { return UICollectionViewCell() }
        
        let cell = context.dequeueReusableCell(withNibName: "FeatureCell", bundle: nil, for: self, at: index) as! FeatureCell
        cell.setup(with: featureViewModel)
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        viewModel = object as? FeatureListViewModel
    }
}
