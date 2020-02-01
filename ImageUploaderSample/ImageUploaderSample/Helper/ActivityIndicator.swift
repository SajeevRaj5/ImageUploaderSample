//
//  ActivityIndicator.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 2/1/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Foundation
import UIKit

// Used for ViewControllers that need to present an activity indicator when loading data.
public protocol ActivityIndicatorPresenter {

    // The activity indicator
    var activityIndicator: UIActivityIndicatorView { get }

    // Show the activity indicator in the view
    func showActivityLoader()

    // Hide the activity indicator in the view
    func hideActivityLoader()
}

public extension ActivityIndicatorPresenter where Self: UIViewController {

    func showActivityLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let welf = self else { return }
            welf.activityIndicator.style = UIActivityIndicatorView.Style.large
            welf.activityIndicator.color = .white
            welf.activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80) //or whatever size you would like
            welf.activityIndicator.center = CGPoint(x: UIScreen.main.bounds.maxX/2, y: UIScreen.main.bounds.maxY/2) //CGPoint(x: welf.view.bounds.size.width / 2, y: welf.view.bounds.height / 2)
            welf.view.addSubview(welf.activityIndicator)
            welf.activityIndicator.layer.zPosition = 1000
            welf.activityIndicator.startAnimating()
        }
    }

    func hideActivityLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let welf = self else { return }
            welf.activityIndicator.stopAnimating()
            welf.activityIndicator.removeFromSuperview()
        }
    }
}
