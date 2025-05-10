//
//  ListProductCell.swift
//  My Products List
//
//  Created by Mostafa Hendawi on 10/05/2025.
//

import UIKit

class ListProductCell: UICollectionViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productRatingView: StarRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        parentView.layer.cornerRadius = 20
    }

}
