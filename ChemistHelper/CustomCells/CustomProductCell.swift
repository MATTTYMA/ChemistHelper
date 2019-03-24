//
//  CustomProductCell.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 20/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import UIKit
import SwipeCellKit

class CustomProductCell: SwipeTableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRetailer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
