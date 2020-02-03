//
//  GalleryDetailPresenterTests.swift
//  ImageUploaderSampleTests
//
//  Created by sajeev Raj on 2/3/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Quick
import Nimble
@testable import ImageUploaderSample

class GalleryDetailPresenterTests: QuickSpec {
    
    class MockView: PresenterToViewGalleryDetailProtocol {
        
        var shouldShowDetailForGallery = false

        func showDetailForGallery(url: URL) {
            shouldShowDetailForGallery = true
        }
    }
    
    var presenter: GalleryDetailPresenter!
    var itemUrl: URL?
    var mockView: MockView!
    
    override func spec() {
        
        beforeEach() {
            self.presenter = GalleryDetailPresenter()
            self.mockView = MockView()
            self.presenter?.view = self.mockView
        }
        
        describe("Dont display detail") {
            
            it("Should not display image for url nil") {
                self.presenter.showDetail()
                expect(self.mockView.shouldShowDetailForGallery).to(equal(false))
            }
        }
        
        describe("Show detail") {
            beforeEach() {
                self.presenter.itemUrl = URL(string:MockGallery.shared.galleryItems.first!.url!)!
            }
            
            it("Should gallery image for url") {
                self.presenter.showDetail()
                expect(self.mockView.shouldShowDetailForGallery).to(equal(true))
            }
        }
    }
}
