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
    fileprivate var selectedProductListViewModel: SelectedProductListViewModel!
    fileprivate var selectedProductListHeaderViewModel: SelectedProductListHeaderViewModel!

    fileprivate let collectionView: UICollectionView = {
        let flowLayout = ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false)
        let collectionView =  UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = Color.SharedColors.white
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Choose Items"
        nextBarButtonItem.isEnabled = false
        setupProductListViewModel()
        setupSelectedProductListViewModel()
        setupAdapter()
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
//        guard let flowLayout = collectionView.collectionViewLayout as? ListCollectionViewLayout else {
//            return
//        }
//        
//        flowLayout.invalidateLayout()
//        adapter.reloadData(completion: nil)
    }
    
    // MARK: - Private functions    
    private func setupProductListViewModel() {
        productListViewModel = ProductListViewModel()
        productListViewModel.delegate = self
        productListViewModel.generateProductViewModels()
    }
    
    private func setupSelectedProductListViewModel() {
        selectedProductListViewModel = SelectedProductListViewModel()
        selectedProductListHeaderViewModel = SelectedProductListHeaderViewModel()
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
        
        selectedProductListViewModel.addProductViewModel(andWithViewModel)
        selectedProductListHeaderViewModel.updateHeaderTextWith(count: selectedProductListViewModel.objectsToDisplay.count)
        adapter.performUpdates(animated: true, completion: nil)
        adapter.reloadData(completion: nil)
    }
}

// MARK: - ListAdapterDataSource
extension ProductsViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var objects: [ListDiffable] = []
        
        if !selectedProductListViewModel.objectsToDisplay.isEmpty {
            objects.append(selectedProductListHeaderViewModel)
        }
        objects.append(selectedProductListViewModel)
        if !productListViewModel.objectsToDisplay.isEmpty {
            objects.append(contentsOf: productListViewModel.objectsToDisplay)
        }

        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is ProductViewModel {
            return AvailableProductsSectionController()
        } else if object is SelectedProductListViewModel {
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
