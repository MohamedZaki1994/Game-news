//
//  FavoriteViewController.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 7/4/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit
import RealmSwift
class FavoriteViewController: UIViewController {


    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let favorite = try! Realm().objects(Favorite.self)
        print(favorite)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
