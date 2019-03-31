//
//  CustomShoppingListItemTableViewCell.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 29/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import UIKit

class CustomShoppingListItemTableViewCell: UITableViewCell {
    
    internal var currentRetailer: String = ""

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UITextField!
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func subButtonPressed(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
