//
//  ProductsVC.swift
//  My Products List
//
//  Created by Mostafa Hendawi on 09/05/2025.
//

import UIKit
import SDWebImage

class ProductsVC: UIViewController {
    
    private let viewModel = ProductViewModel()
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    private let cellId = "GridProductCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        bindViewModel()
        viewModel.fetchNextBatch()
    }
    
    private func setupCollectionView(){
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    private func bindViewModel() {
        viewModel.onProductsUpdated = { [weak self] _ in
            DispatchQueue.main.async {
                self?.productsCollectionView.reloadData()
            }
        }
        
        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
//                self?.showErrorAlert(message: error)
                print("Error: \(error)")
            }
        }
    }
}


extension ProductsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GridProductCell
        cell.productImg.sd_setImage(with: URL(string: viewModel.products[indexPath.row].image), placeholderImage: UIImage(named: "placeholder-image"))
        cell.productNameLbl.text = viewModel.products[indexPath.row].title
        cell.productPriceLbl.text = "$\(viewModel.products[indexPath.row].price)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
