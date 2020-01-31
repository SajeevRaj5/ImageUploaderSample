//
//  ImageHandlerViewController.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/29/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import UIKit

class ImageHandlerViewController: UIViewController {
    typealias CropActionHandler = (UIImage) -> ()

    var closeActionHandler: VoidClosure?
    var cropActionHandler: CropActionHandler?
    
    var image: UIImage? {
        didSet {
            configureView()
        }
    }
    
    var viewMode: ViewMode? = .normal {
        didSet {
            toggleEditView()
        }
    }

    @IBOutlet weak var editView: UIView?
    @IBOutlet weak var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
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
    
    @IBAction func cropButtonAction(_ sender: UIButton) {
        guard let croppedImage = image else { return }
        cropActionHandler?(croppedImage)
    }

}

extension ImageHandlerViewController {
    enum ViewMode {
        case edit
        case normal
    }
}
