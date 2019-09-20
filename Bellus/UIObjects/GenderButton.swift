//
//  GenderButton.swift
//  Bellus
//
//  Created by Rafeeq Ebrahim on 01/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import UIKit

enum Gender: Int16 {
    case Male = 0
    case Female
    case Other
}

@IBDesignable class GenderButton: UIButton {
    var male = false
    
}
