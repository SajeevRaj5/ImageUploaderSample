//
//  ImageViewCell.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import UIKit
import SDWebImage

class ImageViewCell: UICollectionViewCell {

    @IBOutlet weak var galleryImageView: UIImageView?
    
    func configure(url: URL) {
        galleryImageView?.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"))
    }

}
