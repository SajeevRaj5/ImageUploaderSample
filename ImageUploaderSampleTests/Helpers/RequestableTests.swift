//
//  RequestableTests.swift
//  ImageUploaderSampleTests
//
//  Created by sajeev Raj on 2/3/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Quick
import Nimble
@testable import ImageUploaderSample

class RequestableTests: QuickSpec {
    
    override func spec() {
        
        var mockRequestable:  MockRequestable?
        
        beforeEach() {
            mockRequestable = MockRequestable()
        }
        
        describe("Check if loaded") {
            it ("") {
                let requestExpectation = XCTestExpectation(description: "Network request expectation")
                mockRequestable?.request(completion: { (test: ServiceResponse<GalleryResponse>) in
                    requestExpectation.fulfill()
                })
            }
        }
    }
    
    class MockRequestable: Requestable {
        var path: String {
            return "www.google.com"
        }
        
        var parameters: [String : String] {
            return [:]
        }
        
        var queryItems: [(queryName: String, queryValue: String)] {
            return []
        }
        
        var queryParameters: [(queryName: String, queryValue: String)]? {
            return nil
        }
    }
}
