//
//  GalleryViewController.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    var presenter: ViewToPresenterGalleryViewProtocol?
    
    let cellsPerRow = 2
    
    // to check if service is in progress
    var isDataLoading: Bool = false
    
    var imageUrls = [URL]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.galleryCollectionView?.reloadData()
            }
        }
    }

    @IBOutlet weak var galleryCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        
        isDataLoading = true
        presenter?.fetchGalleryItems()
    }
    
    private func addNavigationBarButton() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationController?.navigationItem.rightBarButtonItem = add

    }
    
    private func registerCell() {
        galleryCollectionView?.register(UINib(nibName: ImageViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageViewCell.identifier)
    }
    
    @objc func addTapped() {
        
    }

}

extension GalleryViewController: PresenterToViewGalleryViewProtocol {
    func showImages(imageUrls: [URL]) {
        self.imageUrls += imageUrls
    }
    
    func showError(error: Error) {
        
    }
    
    func dismissLoader() {
        isDataLoading = false
    }
    
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.identifier, for: indexPath) as? ImageViewCell else { return UICollectionViewCell() }
        cell.configure(url: imageUrls[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // if user scroll to last 3 data in the list, start fetching the next list from next page
        guard (indexPath.row == imageUrls.count - 1), !isDataLoading else { return }
        presenter?.fetchGalleryItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let view = galleryCollectionView else { return CGSize(width: 0, height: 0) }
        
         let marginsAndInsets = 5 * 2 + view.safeAreaInsets.left + view.safeAreaInsets.right + 5 * CGFloat(cellsPerRow - 1)
         let itemWidth = ((view.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
         return CGSize(width: itemWidth, height: itemWidth)
     }
    
}

