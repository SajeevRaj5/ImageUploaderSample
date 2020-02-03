//
//  GalleryDetailRouter.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/31/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Foundation
import UIKit

class GalleryDetailRouter {
    static func createModule(with item: GalleryItem) -> ImageHandlerViewController {
        guard let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ImageHandlerViewController.identifier) as? ImageHandlerViewController else { return ImageHandlerViewController() }
        
        var presenter: ViewToPresenterGalleryDetailProtocol = GalleryDetailPresenter()
        presenter.itemUrl = URL(string: item.url ?? "")
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
