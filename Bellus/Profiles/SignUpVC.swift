//
//  SignUpVC.swift
//  Bellus
//
//  Created by Rafeeq Ebrahim on 01/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import RxSwift

class SignUpVC: UIViewController, CLLocationManagerDelegate {
    var splashTimer: Timer!
    var isLocationEnabled: Bool!
    
    private let bag = DisposeBag()
    
    var currentUser: User?
    var managedContext: NSManagedObjectContext!
    
    var locationManger: CLLocationManager!
    
    @IBOutlet weak var btnSignUp: UIButton!
    
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPasswd: UITextField!
    @IBOutlet weak var txtFieldLocation: UITextField!
    @IBOutlet weak var stackViewSignup: UIStackView!
    
    var userSaved: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let coreDataStack = CoreDataStack(modelName: "Bellus")
        managedContext = coreDataStack.managedContext
        
        btnSignUp.layer.cornerRadius = 5.0
        
        isLocationEnabled = false
        
        locationManger = CLLocationManager()
        locationManger.delegate = self
        locationManger.requestAlwaysAuthorization()
        
        
        // subscribe to location enabled event in Settings page
        if let navVC = self.tabBarController?.children[2] as? UINavigationController,
            let settingsVC = navVC.viewControllers[0] as? SettingsVC {
            settingsVC.isLocationEnabled
                .subscribe(onNext: { [weak self] enabled in
                    if (enabled) {
                        self?.locationManger.startUpdatingLocation()
                    } else {
                        self?.locationManger.stopUpdatingLocation()
                    }
                })
                .disposed(by: bag)
        }
        //
        
        self.dismissKeyboardOnTap()
        self.showHideKeyboard()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func clearFields() {
        txtFieldName.text = ""
        txtFieldEmail.text = ""
        txtFieldPasswd.text = ""
        txtFieldLocation.text = ""
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        // Empty field validation
        if ((txtFieldName.text?.count == 0) || (txtFieldEmail.text?.count == 0) ||
            (txtFieldPasswd.text?.count == 0)) {
            present(warningAlert (title: "Warning",
                                  warning: NSLocalizedString("Mandatory fields cannot be empty.", comment: "Error message"),
                    clickOk: "OK"),
                    animated: true,
                    completion: nil)
            return
        }
        
        // Email validation
        if (!isValidEmail(strEmail: txtFieldEmail.text!)){
            present(warningAlert (title: "Warning",
                                  warning: NSLocalizedString("Email id is not valid.", comment: "Error message"),
                    clickOk: "OK"),
                    animated: true,
                    completion: nil)
            
            return
        }
        
        // Check if the email id already exists in the database
        let userFetch: NSFetchRequest<User> = User.fetchRequest()
        userFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(User.email), txtFieldEmail.text!)
        
        do {
            let results = try managedContext.fetch(userFetch)
            if results.count > 0 {
                // user already exists
                self.present(warningAlert(title: "Huda POC",
                                          warning: NSLocalizedString("User already exists!", comment: "Error message"),
                                          clickOk: "OK"),
                             animated: true,
                             completion: nil)
            }
            else {
                currentUser = User(context: managedContext)
                currentUser?.email = txtFieldEmail.text
                currentUser?.name = txtFieldName.text
                currentUser?.location = txtFieldLocation.text
                currentUser?.password = txtFieldPasswd.text
                
                try managedContext.save()
                
                userSaved = true
                
                clearFields()
                dismissKeyboard()
                present(warningAlert (title: "Success",
                                      warning: NSLocalizedString("User created successfully", comment: "Success message"),
                                      clickOk: "OK"),
                        animated: true,
                        completion: nil)
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
}
