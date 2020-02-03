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
    
    var nextIndex: String? = ""
    
    func fetchImages() {
        // when the index is nil, it means that there are no new items, hance return
        guard let index = nextIndex else {
            presenter?.onServerResponseReceival()
            presenter?.onSuccessImagesFetch(items: [])
            return
        }
        
        // start fetching items
        GalleryItem.getAllImages(index: index) { [weak self] (response) in
            guard let welf = self else { return }
            switch response {
            case .success(let result):
                welf.nextIndex = result.nextIndex
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
        GalleryItem.uploadImage(image: image) { [weak self] (response) in
            guard let welf = self else { return }
            switch response {
            case .success(let result):
                welf.presenter?.onSuccessImagesFetch(items: [result] )
            case .failure(let error):
                welf.presenter?.onFailedImagesFetch(error: error)
            case .finally:
                welf.presenter?.onServerResponseReceival()
            }
        }
    }
}

