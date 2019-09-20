//
//  SettingsTests.swift
//  BellusTests
//
//  Created by Rafeeq Ebrahim on 05/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import XCTest
@testable import Bellus

class SettingsTests: XCTestCase {
    var settingsVC: SettingsVC!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as? SettingsVC
        _ = settingsVC.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignOUt() {
        settingsVC.btnSignOut.sendActions(for: .touchUpInside)
        
        XCTAssert(!StateManager.shared.isLoggedIn)
    }
    
    func testLanguageChange() {
        settingsVC.dropDownLang.text = "English"
        settingsVC.dropDownLang.sendActions(for: .valueChanged)
        
        XCTAssert(L8n.currentAppleLanguage() == "en")
    }
}
