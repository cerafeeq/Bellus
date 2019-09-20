//
//  SignUpTests.swift
//  BellusTests
//
//  Created by Rafeeq Ebrahim on 05/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import XCTest
import CoreData
@testable import Bellus

class SignUpTests: XCTestCase {
    var signUpVC: SignUpVC!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
        _ = signUpVC.view
    }

    override func tearDown() {
        signUpVC = nil
    }

    func testCreateUser() {
        let coreDataStack = CoreDataStack(modelName: "Bellus")
        let managedContext = coreDataStack.managedContext
        
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(batchDeleteRequest)
            
        } catch {
            // Error Handling
        }
        
        signUpVC.txtFieldName.text = "TestUser1"
        signUpVC.txtFieldEmail.text = "user1@domain.com"
        signUpVC.txtFieldPasswd.text = "password"
        
        signUpVC.btnSignUp.sendActions(for: .touchUpInside)
        
        XCTAssert(signUpVC.userSaved == true)
    }
}
