//
//  ProductsVC.swift
//  My Products List
//
//  Created by Mostafa Hendawi on 09/05/2025.
//

import UIKit
import SDWebImage
import SkeletonView

class ProductsVC: UIViewController {
    private let viewModel = ProductViewModel()
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    private let gridCellId = "GridProductCell"
    private let listCellId = "ListProductCell"
    private var isGridView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        productsCollectionView.showAnimatedGradientSkeleton()
        
        bindViewModel()
        viewModel.fetchNextBatch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.showAnimatedGradientSkeleton()
    }
    
    private func setupCollectionView(){
        productsCollectionView.isSkeletonable = true
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(UINib(nibName: listCellId, bundle: nil), forCellWithReuseIdentifier: listCellId)
        productsCollectionView.register(UINib(nibName: gridCellId, bundle: nil), forCellWithReuseIdentifier: gridCellId)
    }
    
    private func bindViewModel() {
        viewModel.onProductsUpdated = { [weak self] _ in
            DispatchQueue.main.async {
                self?.productsCollectionView.hideSkeleton()
                self?.productsCollectionView.reloadData()
            }
        }
        
        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: error)
                print("Error: \(error)")
            }
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func showListBtnClicked(_ sender: UIButton) {
        isGridView = false
        productsCollectionView.reloadData()
    }
    
    @IBAction func showGridBtnClicked(_ sender: UIButton) {
        isGridView = true
        productsCollectionView.reloadData()
    }
}

extension ProductsVC: SkeletonCollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return isGridView ? gridCellId : listCellId
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = viewModel.products[indexPath.row]
        if isGridView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gridCellId, for: indexPath) as! GridProductCell
            cell.productImg.sd_setImage(with: URL(string: product.image), placeholderImage: UIImage(named: "placeholder-image"))
            cell.productNameLbl.text = product.title
            cell.productPriceLbl.text = "$\(product.price)"
            cell.productRatingView.rating = Float(product.rating.rate)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCellId, for: indexPath) as! ListProductCell
            cell.productImg.sd_setImage(with: URL(string: product.image), placeholderImage: UIImage(named: "placeholder-image"))
            cell.productNameLbl.text = product.title
            cell.productPriceLbl.text = "$\(product.price)"
            cell.productRatingView.rating = Float(product.rating.rate)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.products.count - 1 {
            viewModel.fetchNextBatch()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isGridView {
            return CGSize(width: 170, height: 250)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 20, height: 150)
        }
    }
}
