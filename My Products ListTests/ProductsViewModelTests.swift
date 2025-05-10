//
//  ProductsViewModelTests.swift
//  My Products List
//
//  Created by Mostafa Hendawi on 10/05/2025.
//

// ProductsViewModelTests.swift
import XCTest
@testable import My_Products_List

final class ProductsViewModelTests: XCTestCase {
    func testInitialFetchAppendsProducts() async {
        let viewModel = ProductViewModel()
        let expectation = expectation(description: "Products Loaded")
        
        viewModel.onProductsUpdated = { products in
            XCTAssertGreaterThan(products.count, 0)
            expectation.fulfill()
        }
        
        viewModel.fetchNextBatch()
        await fulfillment(of: [expectation], timeout: 5)
    }
}
