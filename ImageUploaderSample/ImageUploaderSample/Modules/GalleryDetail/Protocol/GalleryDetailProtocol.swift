//
//  GalleryDetailProtocol.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/31/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Foundation

protocol ViewToPresenterGalleryDetailProtocol {
    var view: PresenterToViewGalleryDetailProtocol? {get set}
    var itemUrl: URL? {get set}
    
    func showDetail()
}

protocol PresenterToViewGalleryDetailProtocol {
    func showDetailForGallery(url: URL)
}
