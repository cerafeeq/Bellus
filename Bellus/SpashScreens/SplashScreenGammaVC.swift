//
//  SplashScreenGammaVC.swift
//  Bellus
//
//  Created by Rafeeq Ebrahim on 01/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import UIKit

class SplashScreenGammaVC: UIViewController {
    var splashTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

        splashTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SplashScreenAlphaVC.splashTimeout), userInfo: nil, repeats: true)
    }
    
    @objc func splashTimeout() {
        splashTimer.invalidate()
        
        self.performSegue(withIdentifier: "SignUp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SignUp"){
            let barViewControllers = segue.destination as! UITabBarController
            barViewControllers.selectedIndex = 1
        }
    }
}
