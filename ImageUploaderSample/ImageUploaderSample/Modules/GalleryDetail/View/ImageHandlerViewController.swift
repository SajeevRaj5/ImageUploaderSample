//
//  ImageHandlerViewController.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/29/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import UIKit

class ImageHandlerViewController: UIViewController {
    typealias SaveActionHandler = (UIImage) -> ()

    var closeActionHandler: VoidClosure?
    var saveActionHandler: SaveActionHandler?
    
    var presenter: ViewToPresenterGalleryDetailProtocol?
    
    var image: UIImage? {
        didSet {
            configureView()
        }
    }
    
    var viewMode: ViewMode? = .edit {
        didSet {
            toggleEditView()
        }
    }

    @IBOutlet weak var editView: UIView?
    @IBOutlet weak var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        toggleEditView()
        
        presenter?.showDetail()
    }
    
    private func configureView() {
        imageView?.image = image
    }
    
    private func toggleEditView() {
        editView?.isHidden = viewMode == .normal
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        closeActionHandler?()
    }
    
    @IBAction func rotateButtonAction(_ sender: UIButton) {
        image = image?.rotate(radians: .pi/2)
        imageView?.image = image
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        guard let originalImage = image else { return }
        dismiss(animated: true, completion: { [weak self] in
            self?.saveActionHandler?(originalImage)
        })
    }

}

extension ImageHandlerViewController {
    enum ViewMode {
        case edit
        case normal
    }
}

extension ImageHandlerViewController: PresenterToViewGalleryDetailProtocol {
    
    func showDetailForGallery(url: URL) {
        imageView?.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"))
    }

}
