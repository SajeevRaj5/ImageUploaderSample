//
//  ImageViewExtension.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(url: URL, placeholderImage: UIImage? = nil) {
        image = placeholderImage
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
        }
    }
}
