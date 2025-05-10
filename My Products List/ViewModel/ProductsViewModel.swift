//
//  ProductsViewModel.swift
//  My Products List
//
//  Created by Mostafa Hendawi on 10/05/2025.
//

import Foundation

class ProductViewModel {
    private(set) var products: [Product] = []
    private var limit = 7
    private var isFetching = false
    private var allProductsLoaded = false

    var onProductsUpdated: (([Product]) -> Void)?
    var onError: ((String) -> Void)?

    func fetchNextBatch() {
        guard !isFetching, !allProductsLoaded else { return }
        isFetching = true

        let url = "https://fakestoreapi.com/products?limit=\(limit)"

        Task {
            do {
                let latestBatch: [Product] = try await NetworkManager.shared.request(
                    urlString: url,
                    responseType: [Product].self
                )

                // Extract only the new items by slicing
                let newItems = Array(latestBatch.dropFirst(products.count))

                if newItems.isEmpty {
                    allProductsLoaded = true
                } else {
                    products.append(contentsOf: newItems)
                    onProductsUpdated?(products)
                }

                // Increase the limit for the next fetch
                limit += 5
                isFetching = false
            } catch {
                onError?(error.localizedDescription)
                isFetching = false
            }
        }
    }
}
