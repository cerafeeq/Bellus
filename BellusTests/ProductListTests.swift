//
//  ProductListTests.swift
//  BellusTests
//
//  Created by Rafeeq Ebrahim on 05/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import XCTest
@testable import Bellus

class ProductListTests: XCTestCase {
    
    var productListVC: ProductListVC!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        productListVC = storyboard.instantiateViewController(withIdentifier: "ProductListVC") as? ProductListVC
        productListVC.category = "haircare"
        _ = productListVC.view
    }
    
    func testNumberOfProducts() {
        XCTAssert(productListVC.products.count == 5)
    }
    

    override func tearDown() {
        productListVC = nil
    }

}
