//
//  ShoppingListProductTableViewController.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 29/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import UIKit

class ShoppingListProductTableViewController: UITableViewController {
    
    private var currentRetailer: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)


        return cell
    }
    

   
}
