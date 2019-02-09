//
//  Repository.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/8/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import Foundation

class rep {
    class func data() {
        if let path = Bundle.main.path(forResource: "head", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> ,
                    let first = jsonResult["Game"] as? [Any] {
                    print(first)
                }
            } catch let error{
                print(error)
            }
        }
    }
    
}
