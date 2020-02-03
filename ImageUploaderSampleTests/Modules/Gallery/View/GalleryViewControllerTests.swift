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
        
        describe("Add Tapped") {
            
            beforeEach() {
                viewController?.addTapped()
            }
            
            it("Should call upload image") {
                expect(presenter?.didUploadImageTap).to(equal(true))
            }
        }
        
        describe("Display Error") {
            
            beforeEach() {
                viewController?.showError(error: NSError(domain: "test error", code: 123, userInfo: nil))
            }
            
            it("Should show error pop up") {
                expect( UIViewController.topMostViewController()).toEventually((beAKindOf(UIViewController.self)), timeout: 10, pollInterval: 1, description: "Should display alert")
            }
        }
        
        describe("Collection view configuration") {
            
            it("Should be equal to row") {
                let numberofrow = viewController?.collectionView(viewController!.galleryCollectionView!, numberOfItemsInSection: 0)
                expect(numberofrow).to(equal(viewController!.imageUrls.count))
            }
        }
        
        describe("Collection view configuration") {
            
            beforeEach() {
                viewController?.imageUrls = MockGallery.shared.galleryItems.map{ URL(string: $0.url ?? "")!}
            }
            
            it("Should configure cell") {
                
                let cell = viewController?.collectionView(viewController!.galleryCollectionView!, cellForItemAt:  IndexPath(row: 0, section: 0)) as? ImageViewCell
                
                expect(cell).toNot(beNil())
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

