//
//  GalleryDetailPresenter.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/31/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Foundation

class GalleryDetailPresenter: ViewToPresenterGalleryDetailProtocol {
    var itemUrl: URL?
    
    var view: PresenterToViewGalleryDetailProtocol?
    
    func showDetail() {
        guard let galleryImageUrl = itemUrl else { return }
       view?.showDetailForGallery(url: galleryImageUrl)
    }
    
}
