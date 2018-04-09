//
//  ProductsViewController.swift
//  testTask
//
//  Created by Yuriy T on 09.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import UIKit
import IGListKit

class ProductsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var nextBarButtonItem: UIBarButtonItem!
    
    // MARK: - Private properties
    fileprivate var adapter: ListAdapter!
    fileprivate var productListViewModel: ProductListViewModel!
    fileprivate let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView =  UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = Color.SharedColors.white
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        nextBarButtonItem.isEnabled = false
        setupProductListViewModel()
        setupAdapter()
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Private functions    
    private func setupProductListViewModel() {
        productListViewModel = ProductListViewModel()
        productListViewModel.delegate = self
        productListViewModel.generateProductViewModels()
    }
    
    private func setupAdapter() {
        let adapterUpdater = ListAdapterUpdater()
        adapter = ListAdapter(updater: adapterUpdater, viewController: self)
        adapter.dataSource = self
        adapter.collectionView = collectionView
    }
}

// MARK: - ProductListViewModelDelegate
extension ProductsViewController: ProductListViewModelDelegate {
    func productListViewModelDidUpdate(_ viewModelList: ProductListViewModel, andWithViewModel: ProductViewModel) {
        adapter.performUpdates(animated: true, completion: nil)
    }
}

// MARK: - ListAdapterDataSource
extension ProductsViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var objects: [ListDiffable] = []
        
        if !productListViewModel.objectsToDisplay.isEmpty {
            objects.append(contentsOf: productListViewModel.objectsToDisplay)
        }

        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is ProductViewModel {
            return AvailableProductsSectionController()
        } else {
            fatalError("boom")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let emptyView = ProductsEmptyView.fromNib()
        let setupText = "Tap to generate products".styled(with: .regular)
        emptyView.setup(with: setupText)
        emptyView.onGenerateAction = { [weak self] in
            self?.productListViewModel.generateProductViewModels()
        }
        
        return emptyView
    }
}
