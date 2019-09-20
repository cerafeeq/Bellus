//
//  CategoryListTests.swift
//  BellusTests
//
//  Created by Rafeeq Ebrahim on 05/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import XCTest
@testable import Bellus

class CategoryListTests: XCTestCase {
    var categoryListVC: CategoryListVC!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        categoryListVC = storyboard.instantiateViewController(withIdentifier: "CategoryListVC") as? CategoryListVC
        _ = categoryListVC.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCategoryCount() {
        XCTAssert(categoryListVC.categories.count == 5)
    }

}
