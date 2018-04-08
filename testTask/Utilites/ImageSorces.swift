//
//  ImageSorces.swift
//  testTask
//
//  Created by Yuriy T on 09.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import Foundation

class ImageSources {
    
    // MARK: - Private properties
    private let imagePathCollections = [
        "https://cdn.pixabay.com/photo/2018/03/29/20/50/wildlife-3273640_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/04/03/19/20/nature-3287747_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/03/22/04/31/bald-eagle-3249232_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/03/30/23/20/nature-3276867_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/04/04/02/10/animals-3288637_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/03/08/03/04/cute-3207722_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/02/26/16/59/fauna-3183485_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/03/08/12/13/mammal-3208486_1280.jpg",
        "https://cdn.pixabay.com/photo/2014/07/31/22/11/polar-bear-406997_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/04/04/19/25/kangaroo-3290805_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/02/01/20/42/cockadoo-3124075_1280.jpg",
        "https://cdn.pixabay.com/photo/2014/09/16/22/42/leopard-448901_1280.jpg",
        "https://cdn.pixabay.com/photo/2014/02/27/16/09/animal-275982_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/02/18/12/48/wood-mouse-3162161_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/02/05/06/40/nature-3131511_1280.jpg",
        "https://cdn.pixabay.com/photo/2013/07/19/00/18/africa-165200_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/03/02/12/06/bird-3193034_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/03/23/13/23/stag-2168278_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/01/24/13/32/ground-squirrel-feeding-3103932_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/03/18/15/27/nature-3237116_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/03/28/16/07/nature-3269671_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/01/31/12/35/nature-3121038_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/01/06/18/01/baby-3065476_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/04/03/14/03/forest-2198463_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/01/29/11/42/winter-3115930_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/02/03/18/25/cat-3128228_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/03/23/20/49/no-person-3254925_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/08/12/10/57/coker-2634079_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/08/07/07/51/street-2601170_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/03/16/12/30/nature-3231104_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/03/14/14/36/rocks-2143310_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/08/03/15/04/people-2576729_1280.jpg",
        "https://cdn.pixabay.com/photo/2015/06/02/20/59/little-girl-795506_1280.jpg",
        "https://cdn.pixabay.com/photo/2016/05/13/22/26/sunset-1391057_1280.jpg",
        "https://cdn.pixabay.com/photo/2015/12/08/00/41/forest-path-1081943_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/02/18/08/49/phang-nga-bay-2076833_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/08/05/22/51/dark-2586359_1280.jpg",
        "https://cdn.pixabay.com/photo/2016/07/10/17/59/sitting-1508134_1280.jpg",
        "https://cdn.pixabay.com/photo/2016/05/02/12/24/sand-1367161_1280.jpg",
        "https://cdn.pixabay.com/photo/2016/11/19/00/33/sunflower-1837481_1280.jpg",
        "https://cdn.pixabay.com/photo/2015/05/14/17/20/adventure-767042_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/06/18/22/01/wheat-2417391_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/08/05/15/00/waterfalls-2584264_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/08/05/12/54/people-2583352_1280.jpg",
        "https://cdn.pixabay.com/photo/2013/03/08/15/16/asher-durand-91573_1280.jpg"
    ] // count = 45
    
    // MARK: - Public methods
    func randomImagePath() -> String {
        let randomIndex = arc4random_uniform(UInt32(imagePathCollections.count))
        
        return imagePathCollections[Int(randomIndex)]
    }
}
