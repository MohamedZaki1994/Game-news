//
//  Favorite.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 7/4/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import Foundation
import RealmSwift

class Favorite: Object {

    @objc dynamic var name: String?
    @objc dynamic var text: String?
    @objc dynamic var image: String?

    convenience init(name: String, text: String, image: String) {
        self.init()
        self.name = name
        self.text = text
        self.image = image
    }

}
