//
//  MockData.swift
//  ImageUploaderSampleTests
//
//  Created by Sajeev on 2/2/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//
import Foundation
@testable import ImageUploaderSample

class MockGallery {
    static var shared = MockGallery()

    var galleryItems: [GalleryItem] {
        return  galleryResponse?.resources ?? []
    }
    
    var galleryResponse: GalleryResponse?

    private init() {
        let jsonData = loadDataFromBundle(withName: "Resources", extensin: "json")
        galleryResponse = try! JSONDecoder().decode(GalleryResponse.self, from: jsonData)
    }

    func loadDataFromBundle(withName name: String, extensin: String) ->  Data {
        let bundle =  Bundle.main
        let url = bundle.url(forResource: name, withExtension: extensin)
        let data = try! Data(contentsOf: url!)
        return data
    }
}
