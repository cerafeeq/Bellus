//
//  EditProfileTests.swift
//  BellusTests
//
//  Created by Rafeeq Ebrahim on 05/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import XCTest
import CoreData
@testable import Bellus

class EditProfileTests: XCTestCase {
    var editProfileVC: EditProfileVC!
    
    override func setUp() {
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
        
        let currentUser: User!
        currentUser = User(context: managedContext)
        currentUser.email = "xyz@gmail.com"
        currentUser.name = "XYZ"
        currentUser.password = "abcd"
        
        do {
            try managedContext.save()
        } catch {
            
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        editProfileVC = storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC
        editProfileVC.userID = currentUser.objectID
        _ =  editProfileVC.view
    }

    override func tearDown() {
        editProfileVC = nil
    }

    func testNumberOfWidgets() {
        XCTAssert(editProfileVC.widgets.count == 6)
    }
}
