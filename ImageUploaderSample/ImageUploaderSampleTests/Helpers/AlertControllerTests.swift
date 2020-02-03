//
//  AlertControllerTests.swift
//  ImageUploaderSampleTests
//
//  Created by sajeev Raj on 2/3/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Quick
import Nimble
@testable import ImageUploaderSample

class AlertControllerTests: QuickSpec {
    override func spec() {
        
        context("did show alert") {
            beforeEach {
                AlertController.show(type: .serviceError)
            }
            
            it("check to show alert") {
                print("***",UIViewController.topMostViewController())
                expect( UIViewController.topMostViewController()).toEventually((beAKindOf(UIAlertController.self)), timeout: 10, pollInterval: 2, description: "Should show alert")
            }
        }
    }
}
