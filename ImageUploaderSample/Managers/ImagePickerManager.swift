//
//  ImagePickerManager.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/29/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

typealias VoidClosure = () -> ()

class ImagePickerManager: NSObject {
    // singleton
    static let shared = ImagePickerManager()
    
    private override init() {
        // restricting initialisation from outside the file
    }
    
    // completion handler
    typealias ImageManagerCompletionHandler = (UIImage?) -> Void
    private var imageManagerCompletionHandler: ImageManagerCompletionHandler?
    
    typealias ImageManagerCancelHandler = VoidClosure
    var imageManagerCancelHandler: ImageManagerCancelHandler?
    
    typealias CheckPermissionCompletionHandler = (Bool) -> Void
    
    func checkPermission(for option: Option, with completionHandler: @escaping CheckPermissionCompletionHandler) {
        switch option {
        case .camera:
            checkCameraAccessPermission(completionHandler: completionHandler)
        case .gallery:
            checkGalleryAccessPermission(completionHandler: completionHandler)
        }
    }
    
    func saveImage(image: UIImage, controller: UIViewController? = nil, completionHandler: @escaping ImageManagerCompletionHandler) {
        
        checkPermission(for: .gallery) { [weak self] (isGranted) in
            // save image
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self?.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    // add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        guard error == nil else {
            // fire completion handler
            imageManagerCompletionHandler?(nil)
            return
        }
        
        // fire completion handler
        imageManagerCompletionHandler?(image)
    }
}

// Permission check
extension ImagePickerManager {
    
    func checkCameraAccessPermission(completionHandler: @escaping CheckPermissionCompletionHandler) {
        // check camera access permission
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            completionHandler(true)
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                completionHandler(granted)
            })
        }
    }
    
    func checkGalleryAccessPermission(completionHandler: @escaping CheckPermissionCompletionHandler) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            completionHandler(true)
        case .denied, .restricted:
            completionHandler(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization {(status) in
                completionHandler(status == PHAuthorizationStatus.authorized)
            }
        @unknown default:
            break
        }
    }
    
    func pickImage(completion: ImageManagerCompletionHandler? = nil) {
        
        if completion != nil {
            imageManagerCompletionHandler = completion
        }
        
        let alertController = UIAlertController(title: "Choose option", message: "", preferredStyle: .actionSheet)

        for option in Option.allCases {
            //            let saveActionButton = UIAlertAction(title: option.listName, style: .default)
            //            { [weak self] _ in
            //                self?.show(type: option, from: UIViewController.topMostViewController())
            //            }
            
            let saveActionButton = UIAlertAction(title: option.listName, style: .default) { [weak self] (action) in
                self?.checkPermission(for: option, with: { (isGranted) in
                    DispatchQueue.main.async {
                        isGranted ? self?.show(type: option, from: UIViewController.topMostViewController()) : self?.showAccessAlert(from: UIViewController.topMostViewController())
                    }
                })
            }
            alertController.addAction(saveActionButton)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action : UIAlertAction!) -> Void in })

        alertController.addAction(cancelAction)

        UIViewController.topMostViewController().present(alertController, animated: true, completion: nil)
        
    }
    
    func show(type: Option, from controller: UIViewController) {
        present(parent: controller, sourceType: type.sourceType)
    }
    
    func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
         let controller = UIImagePickerController()
         controller.delegate = self
         controller.sourceType = sourceType
         DispatchQueue.main.async {
             viewController.present(controller, animated: true, completion: nil)
         }
     }
    
    func showAccessAlert(from viewController: UIViewController) {
        let alert = UIAlertController(title: "Access Denied", message: "Please provide necessary access", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: {
            (action : UIAlertAction!) -> Void in })

        alert.addAction(cancelAction)
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        picker.dismiss(animated: true) { [weak self] in
            
            guard let imageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ImageHandlerViewController.identifier) as? ImageHandlerViewController else { return }
            imageViewController.image = image
            imageViewController.saveActionHandler = { image in
                self?.imageManagerCompletionHandler?(image)
            }
            imageViewController.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                UIViewController.topMostViewController().present(imageViewController, animated: true, completion: nil)
            }
        }
    }
}

extension ImagePickerManager {
    enum Option: String, CaseIterable {
        case camera
        case gallery
        
        var listName: String {
            switch self {
            case .camera: return "Camera"
            case .gallery: return "Gallery"
            }
        }
        
        var sourceType: UIImagePickerController.SourceType {
            switch self {
            case .camera: return .camera
            case .gallery: return .photoLibrary
            }
        }
    }
}
