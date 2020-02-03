//
//  GalleryViewRouterTest.swift
//  ImageUploaderSampleTests
//
//  Created by Sajeev on 2/2/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Quick
import Nimble
@testable import ImageUploaderSample

class GalleryListRouterTests: QuickSpec {

    override func spec() {

        var galleryRouter: GalleryViewRouter!
        var navigationController: MockNavigationController!
        var galleryItem: GalleryItem!

        beforeEach() {
            galleryRouter = GalleryViewRouter()
            galleryItem = MockGallery.shared.galleryItems.first!
        }

        describe("Should show gallery item details page") {

            beforeEach() {
                navigationController = MockNavigationController().getNavigationController(for: GalleryViewRouter.createModule())
            }

            it("should have presented GalleryViewController") {
                galleryRouter.showGalleryDetail(navigationController: navigationController, item: galleryItem)
                expect(navigationController.pushedViewController).to(beAKindOf(GalleryViewController.self))
            }
        }

        describe("Create module") {

            it("Should create the list module and present") {
                let galleryViewController = GalleryViewRouter.createModule()
                expect(galleryViewController).to(beAKindOf(GalleryViewController.self))

                expect(galleryViewController.presenter).toNot(beNil())
                expect(galleryViewController.presenter?.view).toNot(beNil())
                expect(galleryViewController.presenter?.interactor).toNot(beNil())
                expect(galleryViewController.presenter?.router).toNot(beNil())
            }
        }
    }
}
