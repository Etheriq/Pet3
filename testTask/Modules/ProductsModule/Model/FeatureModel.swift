//
//  FeatureModel.swift
//  testTask
//
//  Created by Yuriy T on 12.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import SwiftRandom

struct FeatureModel {
    // MARK: - Public properties
    let actualPrice: Int
    let oldPrice: Int
    let currency: String = "AZN"
    let featureDescription: String
}

extension FeatureModel {
    static func randomFeature() -> FeatureModel {
        let actualPrice: Int = Randoms.randomInt(10, 250)
        let oldPrice: Float = Float(actualPrice) * Randoms.randomFloat(1.5, 3.5)
        let featureDescription = Randoms.randomFakeConversation()
        
        return FeatureModel(actualPrice: actualPrice,
                            oldPrice: Int(oldPrice),
                            featureDescription: featureDescription)
    }
}
