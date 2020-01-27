//
//  GalleryViewRouter.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import UIKit

class GalleryViewRouter: PresenterToRouterGalleryViewProtocol {
    static func createModule() -> GalleryViewController {
        guard let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: GalleryViewController.identifier) as? GalleryViewController else { return GalleryViewController() }
        
        var presenter: ViewToPresenterGalleryViewProtocol & InteractorToPresenterGalleryViewProtocol = GalleryViewPresenter()
        var interactor: PresenterToInteractorGalleryViewProtocol = GalleryViewInteractor()
        let router: PresenterToRouterGalleryViewProtocol = GalleryViewRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    
}
