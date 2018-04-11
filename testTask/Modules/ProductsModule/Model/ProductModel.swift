//
//  ProductModel.swift
//  testTask
//
//  Created by Yuriy T on 09.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import SwiftRandom

struct ProductModel {
    // MARK: - Public properties
    let imagePath: String
    let price: Int
    let currency: String = "$"
    let productDescription: String
}

extension ProductModel {
    static func random() -> ProductModel {
        let imageSources = ImageSources()
        let randomPrice = Randoms.randomInt(10, 999)
        let randomDescription = Randoms.randomFakeConversation()
        
        return ProductModel(imagePath: imageSources.randomImagePath(),
                            price: randomPrice,
                            productDescription: randomDescription)
    }
}
