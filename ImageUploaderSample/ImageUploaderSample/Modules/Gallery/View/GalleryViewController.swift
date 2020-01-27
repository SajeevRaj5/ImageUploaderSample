//
//  GalleryViewController.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    var presenter: ViewToPresenterGalleryViewProtocol?

    @IBOutlet weak var galleryCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension GalleryViewController: PresenterToViewGalleryViewProtocol {
    func showImages() {
        
    }
    
    func showError(error: Error) {
        
    }
    
    func dismissLoader() {
        
    }
    
}

