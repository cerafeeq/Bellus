//
//  StateManager.swift
//  Bellus
//
//  Created by Rafeeq Ebrahim on 04/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import Foundation

class StateManager {
    static let shared = StateManager()
    
    var isLoggedIn: Bool!
    var isLocationEnabled: Bool!
    
    private init() {
    }
}
