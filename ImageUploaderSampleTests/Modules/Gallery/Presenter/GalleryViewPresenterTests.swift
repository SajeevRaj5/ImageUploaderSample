//
//  GalleryViewPresenterTests.swift
//  ImageUploaderSampleTests
//
//  Created by Sajeev on 2/2/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Quick
import Nimble
@testable import ImageUploaderSample

class GalleryViewPresenterTests: QuickSpec {

    class MockInteractor: PresenterToInteractorGalleryViewProtocol {
        
        var presenter: InteractorToPresenterGalleryViewProtocol?
        var isSuccess = true
        var didPickImage = false

        func fetchImages() {
            isSuccess ? presenter?.onSuccessImagesFetch(items: MockGallery.shared.galleryItems) : presenter?.onFailedImagesFetch(error: NSError(domain: "test error", code: 123, userInfo: nil))
            presenter?.onServerResponseReceival()
        }
        
        func pickImage() {
            didPickImage = true
        }
        
        func uploadImage(image: UIImage) {
            isSuccess ? presenter?.onSuccessImagesFetch(items: MockGallery.shared.galleryItems) : presenter?.onFailedImagesFetch(error: NSError(domain: "test error", code: 123, userInfo: nil))
        }
    }
    
    class MockRouter: PresenterToRouterGalleryViewProtocol {
        var mockGalleryItems : GalleryItem?

        func showGalleryDetail(navigationController: UINavigationController, item: GalleryItem) {
            mockGalleryItems = item
        }
        
        static func createModule() -> GalleryViewController {
            return GalleryViewRouter.createModule()
        }
    }
    
    class MockView: PresenterToViewGalleryViewProtocol {
        
        var shouldshowImages = false
        var shouldSelectImage = false
        var shouldShowLoader = false
        var shouldShowError = false
        var shouldDismissLoader = false

        func showImages(imageUrls: [URL]) {
            shouldshowImages = true
        }
        
        func selectedImage(image: UIImage) {
            shouldSelectImage = true
        }
        
        func showLoader() {
            shouldShowLoader = true
        }
        
        func showError(error: Error) {
            shouldShowError = true
        }
        
        func dismissLoader() {
            shouldDismissLoader = true
        }
    }
    
    var presenter: GalleryViewPresenter!
    var mockInteractor: MockInteractor!
    var mockRouter: MockRouter!
    var mockGalleryItems = [GalleryItem]()
    var mockView: MockView!
    
    override func spec() {
        
        beforeEach() {
            self.presenter = GalleryViewPresenter()
            self.mockRouter = MockRouter()
            self.presenter?.router = self.mockRouter
            
            self.mockInteractor = MockInteractor()
            self.mockInteractor.presenter = self.presenter
            self.presenter?.interactor = self.mockInteractor
            
            self.mockView = MockView()
            self.presenter?.view = self.mockView
            self.mockGalleryItems = MockGallery.shared.galleryItems
        }
        
        describe("Success Gallery Fetch") {
            
            it("Should fetched gallery items") {
                self.mockInteractor.isSuccess = true
                self.presenter.fetchGalleryItems()
                expect(self.presenter.galleryItems.count).toNot(equal(0))
                expect(self.mockView.shouldshowImages).to(equal(true))
            }
        }
        
        describe("Error Gallery Fetch") {
            beforeEach() {
            self.presenter.galleryItems = []
            }
            
            it("Should show error for gallery items fetch") {
                self.mockInteractor.isSuccess = false
                self.presenter.fetchGalleryItems()
                expect(self.presenter.galleryItems.count).to(equal(0))
                expect(self.mockView.shouldShowError).to(equal(true))
            }
        }
        
        describe("Image Selection Action") {
            beforeEach() {
                self.presenter.galleryItems = MockGallery.shared.galleryItems
            }
            
            it("Should set selected image") {
                self.presenter.imageSelectedAction(navigationController: MockNavigationController(), selectedIndex: 1)
                expect(self.mockRouter.mockGalleryItems).to(equal(MockGallery.shared.galleryItems[1]))
            }
        }
        
        describe("Upload Image Action") {
              
              it("Should upload Image") {
                  self.presenter.uploadImageButtonTapped()
                  expect(self.mockInteractor.didPickImage).to(equal(true))
              }
          }
    }
}
