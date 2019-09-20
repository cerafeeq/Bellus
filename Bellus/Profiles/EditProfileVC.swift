//
//  EditProfileVC.swift
//  Bellus
//
//  Created by Rafeeq Ebrahim on 01/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import UIKit
import CoreData
import RxSwift

struct Widget: Decodable {
    let id: Int
    let name: String
    let type: String
    let key: String
    let placeholder: String
    let image: String
}

class EditProfileVC: UIViewController {
    var widgets = [Widget]()
    var isLoggedIn: Bool?
    
    private let bag = DisposeBag()
    
    var userID: NSManagedObjectID!
    private var managedContext: NSManagedObjectContext!
    private var currentUser: User?

    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var stackViewSignUp: UIStackView!
    
    @IBOutlet weak var stackViewWidgets: UIStackView!
    var txtFieldName: UITextField!
    var txtFieldEmail: UITextField!
    var txtFieldPhone: UITextField!
    var txtFieldCity: UITextField!
    var txtFieldAddress: UITextField!
    var btnFemale: UIButton!
    var btnMale: UIButton!
    
    var gender = Gender.Male
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Initialize managedContext
        let coreDataStack = CoreDataStack(modelName: "Bellus")
        managedContext = coreDataStack.managedContext
        
        currentUser = managedContext.object(with: userID) as? User
        
        self.title = "Profiles"
        self.tabBarItem.image = UIImage(named: "Person")
        
        inflateLayout()
        
        btnMale.addTarget(self, action: #selector(EditProfileVC.genderBtnClicked(_:)), for: .touchUpInside)
        btnFemale.addTarget(self, action: #selector(EditProfileVC.genderBtnClicked(_:)), for: .touchUpInside)
        
        btnMale.layer.cornerRadius = 15.0
        btnFemale.layer.cornerRadius = 15.0
        
        //Gender Selection
        btnMale.setBackgroundImage(UIImage(named: "pink-background"), for: .selected)
        btnFemale.setBackgroundImage(UIImage(named: "pink-background"), for: .selected)
        
        if (currentUser?.sex == Gender.Male.rawValue) {
            btnMale.isSelected = true
            btnMale.layer.borderWidth = 0
            btnFemale.layer.borderWidth = 1.0
        } else {
            btnFemale.isSelected = true
            btnFemale.layer.borderWidth = 0
            btnMale.layer.borderWidth = 1.0
        }
        
        btnUpdate.layer.cornerRadius = 10.0
        
        txtFieldName.text = currentUser?.name
        txtFieldEmail.text = currentUser?.email
        txtFieldPhone.text = currentUser?.phone
        txtFieldCity.text = currentUser?.city
        txtFieldAddress.text = currentUser?.address
        
        self.dismissKeyboardOnTap()
        self.showHideKeyboard()
    }
    
    func inflateLayout() {
        guard let path = Bundle.main.path(forResource: "layout", ofType: "json") else { return }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            
            widgets = try JSONDecoder().decode([Widget].self, from: data)
        }
        catch let error {
            print("parse error:\(error.localizedDescription)")
            return
        }
        
        for widget in widgets {
            // Name
            let stackView = UIStackView()
            stackView.axis = NSLayoutConstraint.Axis.horizontal
            stackView.distribution  = UIStackView.Distribution.fill
            stackView.alignment = UIStackView.Alignment.center
            stackView.spacing = 20.0
            
            let imageView = UIImageView()
            imageView.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 16.0).isActive = true
            imageView.image = UIImage(named: widget.image)
            stackView.addArrangedSubview(imageView)
            
            switch widget.key {
            case "name":
                txtFieldName = UITextField()
                //txtFieldName.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
                //txtFieldName.heightAnchor.constraint(equalToConstant: 34.0).isActive = true
                txtFieldName.borderStyle = .roundedRect
                txtFieldName.font = UIFont.systemFont(ofSize: 14.0)
                txtFieldName.placeholder = widget.placeholder
                stackView.addArrangedSubview(txtFieldName)
                
            case "email":
                txtFieldEmail = UITextField()
                //txtFieldEmail.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
                //txtFieldEmail.heightAnchor.constraint(equalToConstant: 34.0).isActive = true
                txtFieldEmail.borderStyle = .roundedRect
                txtFieldEmail.font = UIFont.systemFont(ofSize: 14.0)
                txtFieldEmail.placeholder = widget.placeholder
                stackView.addArrangedSubview(txtFieldEmail)
                
            case "phone":
                txtFieldPhone = UITextField()
                //txtFieldPhone.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
                //txtFieldPhone.heightAnchor.constraint(equalToConstant: 34.0).isActive = true
                txtFieldPhone.borderStyle = .roundedRect
                txtFieldPhone.font = UIFont.systemFont(ofSize: 14.0)
                txtFieldPhone.placeholder = widget.placeholder
                stackView.addArrangedSubview(txtFieldPhone)
                
            case "city":
                txtFieldCity = UITextField()
                //txtFieldCity.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
                //txtFieldCity.heightAnchor.constraint(equalToConstant: 34.0).isActive = true
                txtFieldCity.borderStyle = .roundedRect
                txtFieldCity.font = UIFont.systemFont(ofSize: 14.0)
                txtFieldCity.placeholder = widget.placeholder
                stackView.addArrangedSubview(txtFieldCity)
                
            case "address":
                txtFieldAddress = UITextField()
                //txtFieldAddress.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
                //txtFieldAddress.heightAnchor.constraint(equalToConstant: 34.0).isActive = true
                txtFieldAddress.borderStyle = .roundedRect
                txtFieldAddress.font = UIFont.systemFont(ofSize: 14.0)
                txtFieldAddress.placeholder = widget.placeholder
                stackView.addArrangedSubview(txtFieldAddress)
            case "gender":
                let btnStackView = UIStackView()
                btnStackView.axis = NSLayoutConstraint.Axis.horizontal
                btnStackView.distribution  = UIStackView.Distribution.fillEqually
                btnStackView.alignment = UIStackView.Alignment.center
                btnStackView.spacing = 100
                
                btnMale = UIButton()
                btnMale.setTitleColor(.black, for: .normal)
                btnMale.setTitleColor(.white, for: .selected)
                //btnMale.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
                btnMale.heightAnchor.constraint(equalToConstant: 34.0).isActive = true
                btnMale.setTitle("M", for: .normal)
                
                
                btnFemale = UIButton()
                btnFemale.setTitleColor(.black, for: .normal)
                btnFemale.setTitleColor(.white, for: .selected)
                //btnFemale.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
                btnFemale.heightAnchor.constraint(equalToConstant: 34.0).isActive = true
                btnFemale.setTitle("F", for: .normal)
                
                btnStackView.addArrangedSubview(btnMale)
                btnStackView.addArrangedSubview(btnFemale)
                
                stackView.addArrangedSubview(btnStackView)
            default:
                break
            }
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackViewWidgets.addArrangedSubview(stackView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (StateManager.shared.isLoggedIn) {
            stackViewSignUp.isHidden = true
        } else {
            stackViewSignUp.isHidden = false
            clearFields()
        }
    }
    
    func clearFields() {
        txtFieldName.text = ""
        txtFieldEmail.text = ""
        txtFieldPhone.text = ""
        txtFieldCity.text = ""
        txtFieldAddress.text = ""
    }

    @IBAction func genderBtnClicked(_ sender: Any) {
        let btnGender = sender as! UIButton
        
        if (btnGender == btnFemale) {
            btnFemale.isSelected = true
            btnMale.isSelected = false
            btnMale.layer.borderWidth = 1.0
            btnFemale.layer.borderWidth = 0
            
            gender = Gender.Female
        } else {
            btnMale.isSelected = true
            btnFemale.isSelected = false
            btnFemale.layer.borderWidth = 1.0
            btnMale.layer.borderWidth = 0
            
            gender = Gender.Male
        }
    }
    
    @IBAction func updateClicked(_ sender: Any) {
        currentUser?.address = txtFieldAddress.text
        currentUser?.phone = txtFieldPhone.text
        currentUser?.city = txtFieldCity.text
        currentUser?.sex = gender.rawValue
        
        do {
            try managedContext.save()
        }
        catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
}
