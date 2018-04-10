//
//  SelectedProductListHeaderViewModel.swift
//  testTask
//
//  Created by Yuriy T on 11.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import IGListKit

protocol SelectedProductListHeaderViewModelProtocol: class {
    var headerTextAttributedString: NSAttributedString { get }
    
    func updateHeaderTextWith(count: Int)
    func getContainerSize(_ contextWidth: CGFloat) -> CGSize
}

protocol SelectedProductListHeaderViewModelDataUpdater: class {
    func horizontalHeaderSelectedProductDidUpdate(_ viewModel: SelectedProductListHeaderViewModel)
}

class SelectedProductListHeaderViewModel {
    // MARK: - Public properties
    weak var dataUpdater: SelectedProductListHeaderViewModelDataUpdater?
    
    // MARK: - Private properties
    fileprivate var text: NSAttributedString = "Selected 0 item".styled(with: .regular)
    fileprivate let unique = UUID().uuidString
}

// MARK: - SelectedProductListHeaderViewModelProtocol
extension SelectedProductListHeaderViewModel: SelectedProductListHeaderViewModelProtocol {
    var headerTextAttributedString: NSAttributedString {
        return text
    }
    
    func updateHeaderTextWith(count: Int) {
        self.text = String(format: "Selected %i items", count).styled(with: .regular)
        dataUpdater?.horizontalHeaderSelectedProductDidUpdate(self)
    }
    
    func getContainerSize(_ contextWidth: CGFloat) -> CGSize {
        return CGSize(width: contextWidth, height: 50)
    }
}

// MARK: - ListDiffable
extension SelectedProductListHeaderViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return unique as NSString
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? SelectedProductListHeaderViewModel {
            return object.unique == unique
        } else {
            return false
        }
    }
}
