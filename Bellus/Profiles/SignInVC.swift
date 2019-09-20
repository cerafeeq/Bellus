//
//  SignInVC.swift
//  Bellus
//
//  Created by Rafeeq Ebrahim on 02/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import UIKit
import CoreData

class SignInVC: UIViewController {
    let editProfileSegueId = "EditProfile"
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    var currentUser: User?
    var managedContext: NSManagedObjectContext!
    
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPasswd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.title = NSLocalizedString("Profiles", comment: "Navigation header title")
        self.tabBarItem.image = UIImage(named: "Person")
        
        btnSignIn.layer.cornerRadius = 5.0
        
        let coreDataStack = CoreDataStack(modelName: "Bellus")
        managedContext = coreDataStack.managedContext
        
        self.dismissKeyboardOnTap()
        self.showHideKeyboard()
    }
    
    func warningAlert (title:String, warning: String, clickOk: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: warning, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: clickOk, style: UIAlertAction.Style.default, handler: nil))
        
        return alert
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        // Email validation
        if (!isValidEmail(strEmail: txtFieldEmail.text!)){
            present(warningAlert (title: "Warning",
                                  warning: NSLocalizedString("Email id is not valid.", comment: "Error message"),
                                  clickOk: "OK"),
                    animated: true,
                    completion: nil)
            
            return
        }
        
        // Password validation
        if (txtFieldPasswd.text?.count == 0) {
            present(warningAlert (title: "Warning",
                                  warning: NSLocalizedString("Password can't be empty.", comment: "Error message"),
                                  clickOk: "OK"),
                    animated: true,
                    completion: nil)
            return
        }
        
        // Verify if the user exists and the credentials are correct
        let userFetch: NSFetchRequest<User> = User.fetchRequest()
        userFetch.predicate = NSPredicate(format: "email = %@ AND password = %@", txtFieldEmail.text!, txtFieldPasswd.text!)
        
        do {
            let results = try managedContext.fetch(userFetch)
            if results.count <= 0 {
                
                // user does not exist
                self.present(warningAlert(title: "Huda POC",
                                          warning: NSLocalizedString("The email or password is incorrect.", comment: "Error message"),
                                          clickOk: "OK"),
                             animated: true,
                             completion: nil)
            } else {
                currentUser = results.first
                
                StateManager.shared.isLoggedIn = true
                dismissKeyboard()
                // load EditProfile page
                self.performSegue(withIdentifier: "EditProfile", sender: nil)
            }
            
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == editProfileSegueId,
            let destination = segue.destination as? EditProfileVC
        {
            // set the ObjectID for the current user object
            destination.userID = currentUser?.objectID
        }
    }
    
}
