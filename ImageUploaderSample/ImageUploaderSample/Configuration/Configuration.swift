//
//  Configuration.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Foundation

class Configuration {
    
    // the current singleton configuration
    static let current = Configuration()
    
    // all configurations
    private var configurations = [String: Any]()
    
    private init() {
        
        // load all configurations
        configurations = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? [String: Any] ?? [:]
    }
    
    var user: String {
        return configurations["user"] as? String ?? ""
    }
    var password: String {
        return configurations["password"] as? String ?? ""
    }
    var cloudName: String {
        return configurations["cloudName"] as? String ?? ""
    }
    var uploadPreset: String {
        return configurations["uploadPreset"] as? String ?? ""
    }
}
