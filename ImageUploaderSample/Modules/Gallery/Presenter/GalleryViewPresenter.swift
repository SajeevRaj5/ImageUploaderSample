//
//  GalleryViewPresenter.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import UIKit

class GalleryViewPresenter: ViewToPresenterGalleryViewProtocol {
    
    weak var view: PresenterToViewGalleryViewProtocol?
    var interactor: PresenterToInteractorGalleryViewProtocol?
    var router: PresenterToRouterGalleryViewProtocol?
    
    var galleryItems = [GalleryItem]()
    
    func fetchGalleryItems() {
        interactor?.fetchImages()
    }
    
    func imageSelectedAction(navigationController: UINavigationController, selectedIndex: Int) {
        let selectedItem = galleryItems[selectedIndex]
        router?.showGalleryDetail(navigationController: navigationController, item: selectedItem)
    }
    
    func uploadImageButtonTapped() {
        interactor?.pickImage()
    }
}

extension GalleryViewPresenter: InteractorToPresenterGalleryViewProtocol {

    
    func onSuccessImagesFetch(items: [GalleryItem]) {
        galleryItems += items
        let urls = items.compactMap{ URL(string: $0.url ?? "") }
        view?.showImages(imageUrls: urls)
    }
    
    func onFailedImagesFetch(error: Error) {
        view?.showError(error: error)
    }
    
    func onServerResponseReceival() {
        view?.dismissLoader()
    }
    
    func pickedImage(image: UIImage) {
        // start uploading image
        view?.showLoader()
        
        interactor?.uploadImage(image: image)
        
    }
}
