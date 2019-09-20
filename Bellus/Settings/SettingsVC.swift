//
//  SettingsVC.swift
//  Bellus
//
//  Created by Rafeeq Ebrahim on 02/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SettingsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var btnSignout: UIButton!
    
    private var pickerView: UIPickerView!
    
    var langs: [String]!
    
    @IBOutlet weak var dropDownLang: UITextField!
    @IBOutlet weak var switchLocation: UISwitch!
    @IBOutlet weak var stackViewSignUp: UIStackView!
    
    @IBOutlet weak var btnSignOut: UIButton!
    private let bag = DisposeBag()
    
    private let isLocationEnabledSubject = PublishSubject<Bool>()
    var isLocationEnabled: Observable<Bool> {
        return isLocationEnabledSubject.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modifyNavigationBar()
        
        langs = ["English", "عربى"]
        
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        dropDownLang.inputView = pickerView
        
        // Using ReactCocoa to listen Switch changes
        switchLocation.rx.isOn
            .subscribe(onNext: { enabled in
                self.isLocationEnabledSubject.onNext(enabled)
            })
            .disposed(by: bag)
        
        // setting the current language selection
        if (L8n.currentAppleLanguage() == "en") {
            dropDownLang.text = "English"
        }
        else {
            dropDownLang.text = "عربى"
        }
        
        btnSignout.layer.cornerRadius = 10.0
        
        self.dismissKeyboardOnTap()
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        stackViewSignUp.isHidden = false
        StateManager.shared.isLoggedIn = false
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (StateManager.shared.isLoggedIn) {
            stackViewSignUp.isHidden = true
        } else {
            stackViewSignUp.isHidden = false
        }
    }
    
    @IBAction func languageChanged(_ sender: Any) {
        let lang = dropDownLang.text
        
        switch lang {
        case "English":
            L8n.setAppleLAnguageTo(lang: "en")
        case "عربى":
            L8n.setAppleLAnguageTo(lang: "ar")
        default:
            break
        }
    }
    
    func modifyNavigationBar() {
        let navView = UIView()
        
        let label = UILabel()
        label.text = "Settings"
        label.textColor = UIColor(rgb: 0xEE269B)
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = NSTextAlignment.center
        
        // Create the image view
        let image = UIImageView()
        image.image = UIImage(named: "Settings-theme")
        // To maintain the image's aspect ratio:
        let imageAspect = image.image!.size.width/image.image!.size.height
        // Setting the image frame so that it's immediately before the text:
        image.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect - 5.0, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
        image.contentMode = UIView.ContentMode.scaleAspectFit
        
        navView.addSubview(label)
        navView.addSubview(image)
        
        self.navigationItem.titleView = navView
    }
    
    // picker view delegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langs.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return langs[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dropDownLang.text = langs[row]
    }
}
