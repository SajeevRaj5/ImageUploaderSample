//
//  GalleryViewProtocol.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Foundation

protocol ViewToPresenterGalleryViewProtocol {
    var view: PresenterToViewGalleryViewProtocol? {get set}
    var interactor: PresenterToInteractorGalleryViewProtocol? {get set}
    var router: PresenterToRouterGalleryViewProtocol? {get set}
    
    func fetchGalleryItems()
}

protocol PresenterToViewGalleryViewProtocol: class {
    func showImages(imageUrls: [URL])
    func showError(error: Error)
    func dismissLoader()
}

protocol PresenterToInteractorGalleryViewProtocol {
    var presenter: InteractorToPresenterGalleryViewProtocol? {get set}
    func fetchImages()
}

protocol InteractorToPresenterGalleryViewProtocol: class {
    func onSuccessImagesFetch(items: [GalleryItem])
    func onFailedImagesFetch(error: Error)
    func onServerResponseReceival()
}

protocol PresenterToRouterGalleryViewProtocol {
    static func createModule() -> GalleryViewController
}
