//
//  AlertController.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 2/1/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Foundation
import UIKit

class AlertController {
    enum Alert {
        case serviceError
        case emptyError
        
        var title: String {
            switch self {
            case .serviceError: return "Service unavailable"
            case .emptyError:   return "No Data"
            }
        }
        
        var message: String {
            switch self {
            case .serviceError: return "Something went wrong. Please try again later"
            case .emptyError:   return "No data available to diaplay"
            }
        }
        
        var needTwoButtons: Bool {
            switch self {
            case .serviceError: return false
            case .emptyError: return false
            }
        }
    }
    
    static func show(type: Alert, error: Error? = nil, successHandler: VoidClosure? = nil, cancelHandler: VoidClosure? = nil) {
        let alertController = UIAlertController(title: type.title, message: error?.localizedDescription ?? type.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .destructive) { (action) in
            successHandler?()
        }
        alertController.addAction(okAction)
        if type.needTwoButtons {
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
                cancelHandler?()
            }
            alertController.addAction(cancelAction)
        }
        DispatchQueue.main.async {
            UIViewController.topMostViewController().present(alertController, animated: true, completion: nil)
        }
    }
}
