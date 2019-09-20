//
//  SignInVCTests.swift
//  BellusTests
//
//  Created by Rafeeq Ebrahim on 05/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import XCTest
import CoreData
@testable import Bellus

class SignInVCTests: XCTestCase {
    
    var signInVC: SignInVC!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        signInVC = storyboard.instantiateViewController(withIdentifier: "SignInVC") as? SignInVC
        _ = signInVC.view
    }

    override func tearDown() {
        signInVC = nil
    }

    func testInvalidEmail() {
        let result = isValidEmail(strEmail: "invalid_email")
        
        // Verify alert is presented
        XCTAssert(result == false)
    }
    
    func testVerifyUserLogin() {
        // Add test user
        let coreDataStack = CoreDataStack(modelName: "Bellus")
        let managedContext = coreDataStack.managedContext
        
        let currentUser: User!
        currentUser = User(context: managedContext)
        currentUser.email = "xyz@gmail.com"
        currentUser.name = "XYZ"
        currentUser.password = "abcd"
        
        do {
            try managedContext.save()
        } catch {
            
        }
        
        // verify user login
        signInVC.txtFieldEmail.text = "xyz@gmail.com"
        signInVC.txtFieldPasswd.text = "abcd"
        
        signInVC.btnSignIn.sendActions(for: .touchUpInside)
        
        XCTAssert(StateManager.shared.isLoggedIn == true)
    }
    
    func testInvalidUserLogin() {
        signInVC.txtFieldEmail.text = "wrong@user.com"
        signInVC.txtFieldPasswd.text = "wrong_password"
        
        signInVC.btnSignIn.sendActions(for: .touchUpInside)
        
        XCTAssert(StateManager.shared.isLoggedIn == false)
    }
}
