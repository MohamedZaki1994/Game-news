//
//  Repository.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/8/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import Foundation
class rep {
    class func data(resource: String, success: ((DashboardModel) -> Void)) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonData = try JSONDecoder().decode(DashboardModel.self, from: data)
                guard jsonData.games != nil else {return}
                success(jsonData)
            } catch let error{
                print(error)
            }
        }
    }
}


