//
//  GalleryViewPresenter.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import UIKit

class GalleryViewPresenter: ViewToPresenterGalleryViewProtocol {
    func uploadImageButtonTapped() {
        interactor?.pickImage()
    }
    
    
    weak var view: PresenterToViewGalleryViewProtocol?
    var interactor: PresenterToInteractorGalleryViewProtocol?
    var router: PresenterToRouterGalleryViewProtocol?
    
    func fetchGalleryItems() {
        interactor?.fetchImages()
    }
    
    
}

extension GalleryViewPresenter: InteractorToPresenterGalleryViewProtocol {

    
    func onSuccessImagesFetch(items: [GalleryItem]) {
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
        view?.selectedImage(image: image)
    }
}
