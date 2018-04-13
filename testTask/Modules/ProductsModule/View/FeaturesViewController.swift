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
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var totalPriceLabel: UILabel!
    @IBOutlet private weak var payButton: UIButton!
    
    // MARK: - Public proreties
    var selectedProductListViewModel: SelectedProductListViewModel!
    var selectedProductListHeaderViewModel: SelectedProductListHeaderViewModel!

    // MARK: - Private properties
    fileprivate var adapter: ListAdapter!
    fileprivate var featureListViewModel: FeatureListViewModel!
    fileprivate let horizontalSectionController = HorizontalSelectedProductsSectionController()
    fileprivate let totalPriceViewModel = TotalPriceFeatureViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add features"
        totalLabel.attributedText = "Total".styled(with: .regular)
        collectionView.backgroundColor = Color.SharedColors.featureBackground
        selectedProductListViewModel.delegate = self
        selectedProductListViewModel.dataUpdater = horizontalSectionController
        totalPriceViewModel.dataUpdater = self
        setupFeatureListViewModel()
        setupAdapter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateAdapter()
    }
    
    // MARK: - Actions
    @IBAction func payButtonAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Hello", message: "You need to pay \(totalPriceViewModel.totalPrice) \(totalPriceViewModel.currency)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private functions
    private func setupFeatureListViewModel() {
        featureListViewModel = FeatureListViewModel()
        featureListViewModel.delegate = self
        featureListViewModel.generateFeatureViewModels()
    }
    
    private func setupAdapter() {
        let adapterUpdater = ListAdapterUpdater()
        adapter = ListAdapter(updater: adapterUpdater, viewController: self)
        adapter.dataSource = self
        adapter.collectionView = collectionView
    }
    
    fileprivate func updateAdapter() {
        selectedProductListHeaderViewModel.updateHeaderTextWith(count: selectedProductListViewModel.objectsToDisplay.count)
        adapter.performUpdates(animated: true, completion: nil)
    }
}

// MARK: - TotalPriceFeatureViewModelDataUpdater
extension FeaturesViewController: TotalPriceFeatureViewModelDataUpdater {
    func totalPriceAndCurrencyWasUpdated(_ viewModel: TotalPriceFeatureViewModel) {
        payButton.isEnabled = viewModel.totalPrice != 0
        totalPriceLabel.attributedText = String(format: "%i %@", viewModel.totalPrice, viewModel.currency).styled(with: .bold)
    }
}

// MARK: - FeatureListViewModelDelegate
extension FeaturesViewController: FeatureListViewModelDelegate {
    func featureWasIncrease(_ viewModel: FeatureViewModel) {
        totalPriceViewModel.increasePrice(viewModel.featureActualPriceInt)
        totalPriceViewModel.updateCurrency(viewModel.featureCurrencyString)
    }
    
    func featureWasDecrease(_ viewModel: FeatureViewModel) {
        totalPriceViewModel.decreasePrice(viewModel.featureActualPriceInt)
        totalPriceViewModel.updateCurrency(viewModel.featureCurrencyString)
    }
    
    func featureListViewModelDidUpdate(_ listViewModel: FeatureListViewModel, andWithViewModel viewModel: FeatureViewModel) {
        updateAdapter()
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
        if !featureListViewModel.objectsToDisplay.isEmpty {
            objects.append(featureListViewModel)
        }
        
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
         if object is SelectedProductListViewModel {
            return horizontalSectionController
        } else if object is SelectedProductListHeaderViewModel {
            return SelectedProductListHeaderSectionController()
         } else if object is FeatureListViewModel {
            return FeaturesSectionController()
         } else  {
            fatalError("boom")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
