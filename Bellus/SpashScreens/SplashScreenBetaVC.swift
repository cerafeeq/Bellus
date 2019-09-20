//
//  SplashScreenBetaVC.swift
//  Bellus
//
//  Created by Rafeeq Ebrahim on 01/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import UIKit

class SplashScreenBetaVC: UIViewController {
    var splashTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

        splashTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SplashScreenAlphaVC.splashTimeout), userInfo: nil, repeats: true)
    }
    
    @objc func splashTimeout() {
        splashTimer.invalidate()
        
        self.performSegue(withIdentifier: "Gamma", sender: self)
    }
}
