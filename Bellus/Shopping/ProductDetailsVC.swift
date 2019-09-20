//
//  ProductDetailsVC.swift
//  Bellus
//
//  Created by Rafeeq Ebrahim on 02/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var dropDownQty: UITextField!
    var product: Product!
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var txtViewDesc: UITextView!
    
    var quantities: [String]!
    
    @IBOutlet weak var btnBuynow: UIButton!
    
    private var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        dropDownQty.inputView = pickerView
        
        quantities = ["1", "2", "3", "4"]
        
        // set default quantity to 1
        dropDownQty.text = "1"

        self.navigationItem.title = NSLocalizedString("Product Details", comment: "Navigation header title")
        
        btnBuynow.layer.cornerRadius = 5.0
        
        imgProduct.image = UIImage(named: product.image)
        lblName.text = product.name
        lblPrice.text = product.price
        txtViewDesc.text = product.description
        
        dismissKeyboardOnTap()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quantities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return quantities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dropDownQty.text = quantities[row]
    }
}
