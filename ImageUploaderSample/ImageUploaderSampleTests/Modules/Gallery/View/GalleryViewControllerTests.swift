//
//  GalleryViewControllerTests.swift
//  ImageUploaderSampleTests
//
//  Created by Sajeev on 2/3/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Quick
import Nimble
@testable import ImageUploaderSample

class GalleryViewControllerTests: QuickSpec {
    
    override func spec() {
        var viewController: GalleryViewController?
        var presenter: MockPresenter?
        
        beforeEach() {
            viewController = GalleryViewRouter.createModule()
            presenter = MockPresenter()
            viewController?.presenter = presenter
            _ = viewController?.view
        }
        
        describe("Check if loaded") {
            
            it("Should load view") {
                expect(viewController?.title).toNot(beNil())
                expect(viewController?.navigationItem.rightBarButtonItem).toNot(beNil())
                expect(viewController?.showLoader())
                

            }
        }
        
        describe("Show Loader") {
            beforeEach {
                viewController?.showLoader()
            }
            
            it("Should show loader") {
                expect(viewController?.activityIndicator.isAnimating).to(equal(false))
            }
        }

        describe("Hide Loader") {
            beforeEach {
                viewController?.dismissLoader()
            }
            
            it("Should hide loader") {
                expect(viewController?.activityIndicator.isAnimating).to(equal(false))
            }
        }
        describe("Check if recived data is displayed") {
            
            beforeEach() {
                viewController?.imageUrls = MockGallery.shared.galleryItems.map{ URL(string: $0.url ?? "")!}
            }
            
            it("Should refresh view") {
                expect(viewController?.galleryCollectionView?.numberOfItems(inSection: 0)).to(equal(viewController?.imageUrls.count ?? 0))
            }
        }
        
        describe("Show images") {
            
            beforeEach() {
                viewController?.showImages(imageUrls:  MockGallery.shared.galleryItems.map{ URL(string: $0.url ?? "")!})
            }
            
            it("Should refresh view") {
                expect(viewController?.imageUrls.count).toNot(equal(0))
            }
        }
    }

    class MockPresenter: ViewToPresenterGalleryViewProtocol {
        
        var didUploadImageTap = false
        var didFetchGalleryItems = false
        var didImageSelectedAction = false
        
        var view: PresenterToViewGalleryViewProtocol?
        var interactor: PresenterToInteractorGalleryViewProtocol?
        var router: PresenterToRouterGalleryViewProtocol?
        var galleryItems: [GalleryItem]?
        
        func uploadImageButtonTapped() {
            didUploadImageTap = true
        }
        func fetchGalleryItems() {
            didFetchGalleryItems = true
        }
        func imageSelectedAction(navigationController: UINavigationController, selectedIndex: Int){
            didImageSelectedAction = true
        }
    }
}

