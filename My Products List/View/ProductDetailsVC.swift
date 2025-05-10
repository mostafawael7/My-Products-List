//
//  ProductDetailsVC.swift
//  My Products List
//
//  Created by Mostafa Hendawi on 10/05/2025.
//

import UIKit
import SDWebImage
import Cosmos

class ProductDetailsVC: UIViewController {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productRating: CosmosView!
    @IBOutlet weak var productRatingLbl: UILabel!
    @IBOutlet weak var productReviewsCountLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productDescriptionLbl: UILabel!
    @IBOutlet weak var productCategoryView: UIView!
    @IBOutlet weak var productCategoryLbl: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productCategoryView.layer.cornerRadius = 18
        productCategoryView.layer.borderWidth = 1
        productCategoryView.layer.borderColor = UIColor.init(hex: "587CD6").cgColor
        productRating.settings.fillMode = .precise
        
        if let product = product {
            productImg.sd_setImage(with: URL(string: product.image), placeholderImage: UIImage(named: "placeholder-image"))
            productRating.rating = product.rating.rate
            productRatingLbl.text = "\(product.rating.rate)"
            productNameLbl.text = product.title
            productPriceLbl.text = "$\(product.price)"
            productReviewsCountLbl.text = "Based on \(product.rating.count) reviews"
            productDescriptionLbl.text = product.description
            productCategoryLbl.text = product.category.rawValue
            print(product)
        }
    }
}
