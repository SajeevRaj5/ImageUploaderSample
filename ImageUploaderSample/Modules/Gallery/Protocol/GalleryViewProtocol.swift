//
//  GalleryViewProtocol.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import UIKit

protocol ViewToPresenterGalleryViewProtocol {
    var view: PresenterToViewGalleryViewProtocol? {get set}
    var interactor: PresenterToInteractorGalleryViewProtocol? {get set}
    var router: PresenterToRouterGalleryViewProtocol? {get set}
    
    func uploadImageButtonTapped()
    func fetchGalleryItems()
    func imageSelectedAction(navigationController: UINavigationController, selectedIndex: Int)
}

protocol PresenterToViewGalleryViewProtocol: class {
    func showImages(imageUrls: [URL])
    func showError(error: Error)
    func dismissLoader()
    func showLoader()
}

protocol PresenterToInteractorGalleryViewProtocol {
    var presenter: InteractorToPresenterGalleryViewProtocol? {get set}
    func fetchImages()
    func pickImage()
    func uploadImage(image: UIImage)
}

protocol InteractorToPresenterGalleryViewProtocol: class {
    func onSuccessImagesFetch(items: [GalleryItem])
    func onFailedImagesFetch(error: Error)
    func onServerResponseReceival()
    func pickedImage(image: UIImage)
}

protocol PresenterToRouterGalleryViewProtocol {
    static func createModule() -> GalleryViewController
    func showGalleryDetail(navigationController: UINavigationController, item: GalleryItem)
}
