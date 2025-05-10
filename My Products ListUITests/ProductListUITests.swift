//
//  ProductListUITests.swift
//  My Products List
//
//  Created by Mostafa Hendawi on 10/05/2025.
//

import XCTest

final class ProductListUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testCollectionViewLoads() {
        let collectionView = app.collectionViews["productsCollectionView"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5))
    }
}
