//
//  DashboardModel.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/23/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import Foundation
class DashboardModel: Codable{
    
    var games: [Game]?
}
class Game: Codable {
    var name: String?
    var text: String?
}
