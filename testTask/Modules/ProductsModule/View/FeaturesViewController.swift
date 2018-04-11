//
//  FeaturesViewController.swift
//  testTask
//
//  Created by Yuriy T on 11.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import IGListKit

class FeaturesViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Public proreties
    var selectedProductListViewModel: SelectedProductListViewModel!
    var selectedProductListHeaderViewModel: SelectedProductListHeaderViewModel!

    // MARK: - Private properties
    fileprivate var adapter: ListAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add features"
        collectionView.backgroundColor = Color.SharedColors.lightGray
        selectedProductListViewModel.delegate = self
        setupAdapter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateAdapter()
    }
    
    // MARK: - Private functions
    private func setupAdapter() {
        let adapterUpdater = ListAdapterUpdater()
        adapter = ListAdapter(updater: adapterUpdater, viewController: self)
        adapter.dataSource = self
        adapter.collectionView = collectionView
    }
    
    fileprivate func updateAdapter() {
        selectedProductListHeaderViewModel.updateHeaderTextWith(count: selectedProductListViewModel.objectsToDisplay.count)
        adapter.performUpdates(animated: true, completion: { (complete) in
            if complete {
                self.adapter.reloadData(completion: nil)
            }
        })
    }
}

// MARK: - ProductListViewModelDelegate
extension FeaturesViewController: SelectedProductListViewModelDelegate {
    func selectedProductViewModelDidDeselected() {
        updateAdapter()
    }
}

// MARK: - ListAdapterDataSource
extension FeaturesViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var objects: [ListDiffable] = []
        
        if !selectedProductListViewModel.objectsToDisplay.isEmpty {
            objects.append(selectedProductListHeaderViewModel)
        }
        objects.append(selectedProductListViewModel)
        
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
         if object is SelectedProductListViewModel {
            return HorizontalSelectedProductsSectionController()
        } else if object is SelectedProductListHeaderViewModel {
            return SelectedProductListHeaderSectionController()
        } else  {
            fatalError("boom")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
