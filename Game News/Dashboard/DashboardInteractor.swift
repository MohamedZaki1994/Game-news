//
//  DashboardInteractor.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/23/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import Foundation

class DashboardInteractor {

    var viewModel = DashboardViewModel()

    func getData(sucess: (DashboardViewModel) -> Void) {
        rep.data { model in
            viewModel.names = model.games?.compactMap({ (games) in
                return games.name
            })
            sucess(viewModel)
        }
    }
    func testNotification() {
        let array = ["name1": "We are the chosen ones", "name2":"we sacrifices our blood"]
NotificationCenter.default.post(name: Notification.Name("didReceiveData"), object: nil, userInfo: array)
    }
}
