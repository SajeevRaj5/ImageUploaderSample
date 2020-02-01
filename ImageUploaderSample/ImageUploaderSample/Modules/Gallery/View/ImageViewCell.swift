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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(url: URL) {
//        galleryImageView?.setImage(url: url, placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"))
        self.galleryImageView?.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"))

    }

}
