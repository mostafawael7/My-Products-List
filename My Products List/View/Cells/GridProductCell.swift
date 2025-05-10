//
//  GridProductCell.swift
//  My Products List
//
//  Created by Mostafa Hendawi on 10/05/2025.
//

import UIKit
import Cosmos

class GridProductCell: UICollectionViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productRatingView: CosmosView!
    @IBOutlet weak var productRatingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        parentView.layer.cornerRadius = 20
        productRatingView.settings.fillMode = .precise
    }
}
