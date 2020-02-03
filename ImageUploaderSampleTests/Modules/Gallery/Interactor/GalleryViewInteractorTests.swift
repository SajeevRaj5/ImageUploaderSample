//
//  GalleryViewInteractorTests.swift
//  ImageUploaderSampleTests
//
//  Created by Sajeev on 2/2/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//


import Quick
import Nimble
@testable import ImageUploaderSample

class GalleryViewInteractorTests: QuickSpec {

    class MockPresenter: InteractorToPresenterGalleryViewProtocol {
        var mockGalleryItems = [GalleryItem]()
        var didonServerResponseReceival = false
        var error: Error?
        var didPickImage = false
        
        func onSuccessImagesFetch(items: [GalleryItem]) {
            mockGalleryItems = items
        }
        
        func onFailedImagesFetch(error: Error) {
            self.error = error
        }
        
        func onServerResponseReceival() {
            didonServerResponseReceival = true
        }
        
        func pickedImage(image: UIImage) {
            // start uploading image
            didPickImage = true
        }
    }
    
    override func spec() {
        
        var presenter: MockPresenter!
        var interactor: GalleryViewInteractor!
        
        beforeEach() {
            interactor = GalleryViewInteractor()
            presenter = MockPresenter()
            interactor.presenter = presenter
        }
        describe("Image Fetch") {
            
            beforeEach() {
                interactor.nextIndex = nil
            }
            
            it("Should not fetch images") {
                interactor.fetchImages()
                expect(presenter.didonServerResponseReceival).to(equal(true))
                expect(presenter.mockGalleryItems.count).to(equal(0))
            }
        }
        
        describe("Image Fetch") {
            
            beforeEach() {
                interactor.nextIndex = ""
            }
            
            it("Should fetched images") {
                interactor.fetchImages()
                expect(presenter.didonServerResponseReceival).toEventually(equal(true), timeout: 60, pollInterval: 5, description: "Should fetch images")
                expect(presenter.mockGalleryItems.count).toNot(equal(0))
            }
        }
    }
}
