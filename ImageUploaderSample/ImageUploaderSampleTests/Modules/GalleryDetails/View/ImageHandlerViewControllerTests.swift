//
//  ImageHandlerViewControllerTests.swift
//  ImageUploaderSampleTests
//
//  Created by sajeev Raj on 2/3/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Quick
import Nimble
@testable import ImageUploaderSample

class ImageHandlerViewControllerTests: QuickSpec {
    
    override func spec() {
        var viewController: ImageHandlerViewController?
        var presenter: MockPresenter?
        
        beforeEach() {
            viewController = GalleryDetailRouter.createModule(with: MockGallery.shared.galleryItems.first!)
            presenter = MockPresenter()
            viewController?.presenter = presenter
            _ = viewController?.view
            presenter?.itemUrl = URL(string:MockGallery.shared.galleryItems.first!.url!)!

        }
        
        describe("Check if loaded") {
            
            it("Should load view") {
                expect(presenter?.didShowDetail).to(equal(true))
            }
        }

        describe("Should configure mode") {
            beforeEach {
                viewController?.viewMode = .normal
            }
            
            it("Should detail page") {
                expect(viewController?.editView?.isHidden).to(equal(true))
            }
        }

        describe("Should configure mode") {
            beforeEach {
                viewController?.viewMode = .edit
            }
            
            it("Should edit page") {
                expect(viewController?.editView?.isHidden).to(equal(false))
            }
        }
        
        describe("Should display image") {

            it("Should edit page") {
                viewController?.showDetailForGallery(url:presenter!.itemUrl!)
                expect(viewController?.imageView?.image).toNot(beNil())
            }
        }
        
        describe("Should display image") {

            it("Should edit page") {
                viewController?.showDetailForGallery(url: presenter!.itemUrl!)
                expect(viewController?.imageView?.image).toNot(beNil())
            }
        }
        
    }

    class MockPresenter: ViewToPresenterGalleryDetailProtocol {
        
        var didShowDetail = false
        
        var view: PresenterToViewGalleryDetailProtocol?
        var itemUrl: URL?
        
        func showDetail() {
            didShowDetail = true
        }
    }
}

