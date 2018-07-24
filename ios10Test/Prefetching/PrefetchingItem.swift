//
//  PrefetchingItem.swift
//  ios10Test
//
//  Created by ジェローム　チャ on 2018/07/19.
//  Copyright © 2018 ジェローム　チャ. All rights reserved.
//

import UIKit

struct PrefetchingItem {
    let urlString: String
    lazy var url: URL = {
        return URL(string: self.urlString)! //Bad thing, but it's for the demo
    }()
    var image: UIImage?

    init(urlString: String) {
        self.urlString = urlString
    }
}
