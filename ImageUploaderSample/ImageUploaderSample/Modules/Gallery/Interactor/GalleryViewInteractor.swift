//
//  GalleryViewInteractor.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import UIKit

class GalleryViewInteractor: PresenterToInteractorGalleryViewProtocol {
    
    weak var presenter: InteractorToPresenterGalleryViewProtocol?
    
    var nextIndex = ""
    
    func fetchImages() {
        GalleryItem.getAllImages(index: nextIndex) { [weak self] (response) in
            guard let welf = self else { return }
            switch response {
            case .success(let result):
                welf.nextIndex = result.nextIndex ?? ""
                welf.presenter?.onSuccessImagesFetch(items: result.resources ?? [])
            case .failure(let error):
                welf.presenter?.onFailedImagesFetch(error: error)
            case .finally:
                welf.presenter?.onServerResponseReceival()
            }
        }
    }
    
    func pickImage() {
        ImagePickerManager.shared.pickImage { [weak self] (image) in
            guard let selectedImage = image else { return }
            self?.presenter?.pickedImage(image: selectedImage)
        }
    }
    
    func uploadImage(image: UIImage) {
        GalleryItem.uploadImage(image: image) { (response) in
            
        }
            
    }
    
}

