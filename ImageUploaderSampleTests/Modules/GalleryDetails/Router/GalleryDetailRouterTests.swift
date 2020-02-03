//
//  GalleryDetailRouterTests.swift
//  ImageUploaderSampleTests
//
//  Created by sajeev Raj on 2/3/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Quick
import Nimble
@testable import ImageUploaderSample

class GalleryDetailRouterTests: QuickSpec {
    override func spec() {
        
        var galleryRouter: GalleryDetailRouter!
        var navigationController: MockNavigationController!
        
        beforeEach() {
            galleryRouter = GalleryDetailRouter()
        }
        
        describe("Create module") {
            
            it("Should create the list module and present") {
                let galleryDetailViewController = GalleryDetailRouter.createModule(with: MockGallery.shared.galleryItems.first!)
                expect(galleryDetailViewController).to(beAKindOf(ImageHandlerViewController.self))
                expect(galleryDetailViewController.presenter).toNot(beNil())
                expect(galleryDetailViewController.presenter?.view).toNot(beNil())
                expect(galleryDetailViewController.presenter?.itemUrl).toNot(beNil())
            }
        }
    }
}
