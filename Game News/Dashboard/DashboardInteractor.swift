//
//  DashboardInteractor.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/23/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import Foundation

class DashboardInteractor {

    func getData(sucess: (DashboardModel) -> Void) {
        rep.data { model in
            print(model)
            sucess(model)
        }
    }
}
