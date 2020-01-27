//
//  GalleryViewPresenter.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Foundation

class GalleryViewPresenter: ViewToPresenterGalleryViewProtocol {
    
    weak var view: PresenterToViewGalleryViewProtocol?
    var interactor: PresenterToInteractorGalleryViewProtocol?
    var router: PresenterToRouterGalleryViewProtocol?
    
    func fetchGalleryItems() {
        
    }
    
    
}

extension GalleryViewPresenter: InteractorToPresenterGalleryViewProtocol {
    func onSuccessImagesFetch(events: [GalleryItem], totalEntriesCount: Int) {
        
    }
    
    func onFailedImagesFetch(error: Error) {
        
    }
    
    func onServerResponseReceival() {
        
    }
    
    
}
