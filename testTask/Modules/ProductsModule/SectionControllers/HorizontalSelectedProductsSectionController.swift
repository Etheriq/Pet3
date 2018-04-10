//
//  HorizontalSelectedProductsSectionController.swift
//  testTask
//
//  Created by Yuriy T on 10.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import IGListKit

class HorizontalSelectedProductsSectionController: ListSectionController {
    
    // MARK: - Private properties
    fileprivate var viewModel: SelectedProductListViewModel!
    fileprivate lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
}

extension HorizontalSelectedProductsSectionController {
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        
        let width = context.containerSize.width
        let height = context.containerSize.height / 4 + 20
        
        return CGSize(width: width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext else { return UICollectionViewCell() }
        
        let cell = context.dequeueReusableCell(withNibName: "HorizontalSelectedProductCell", bundle: nil, for: self, at: index) as! HorizontalSelectedProductCell
        adapter.collectionView = cell.collectionView
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        viewModel = object as? SelectedProductListViewModel
    }
}

// MARK: - ListAdapterDataSource
extension HorizontalSelectedProductsSectionController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var objects: [ListDiffable] = []
        
        if !viewModel.objectsToDisplay.isEmpty {
            objects.append(contentsOf: viewModel.objectsToDisplay)
        }
                
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is SelectedProductViewModel {
            return SelectedProductsSectionController()
        } else {
            fatalError("boom")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let emptyView = ProductsEmptyView.fromNib()
        let infoText = "No selected items".styled(with: .regular)
        emptyView.setup(with: infoText)
        
        return emptyView
    }
}
